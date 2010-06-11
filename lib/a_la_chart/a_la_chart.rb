module ALaChart
  extend ActiveSupport::Concern
  included do
    extlib_inheritable_accessor(:_helpers) { Module.new }
  end
  
  module HelperMethods
    def meta(the_case=nil)
      if the_case.blank?
        (@metadata ||= {})['_'] ||= defined?(get_meta) ? get_meta : {}
        # @metadata ||= defined?(get_meta) ? get_meta : {}
      else
        (@metadata ||= {})[the_case] ||= respond_to?("get_meta_#{the_case.to_s}") ? send("get_meta_#{the_case.to_s}") : []
        # @metadata ||= respond_to?("get_meta_#{the_case.to_s}") ? send("get_meta_#{the_case.to_s}") : []
      end
    end
    
    def data(the_case=nil)
      if the_case.blank?
        (@data ||= {})['_'] ||= defined?(get_data) ? get_data : []
      else
        (@data ||= {})[the_case] ||= respond_to?("get_data_#{the_case.to_s}") ? send("get_data_#{the_case.to_s}") : []
      end
    end
    
    def value(object, key, the_case=nil)
      return '' if object.blank? || key.blank?
      
      # if there is a meta map, use it. else try the key itself
      key_field = meta(the_case)[key] || key
      
      return '' if key_field.blank?
      
      if key_field.class == Proc
        # TODO: How to do this in the context of the controller?
        val = key_field.call(object)
      elsif key_field.class == Fixnum
        val = object[key_field] if object.respond_to?('[]')
      elsif object.class != Array
        val = object[key_field] if object.respond_to?('[]')
        val = (object.respond_to?(key_field) ? object.send(key_field) : nil) if val.nil?
        val
      end
    end
    
    def set_chart(chart_type)
      send "set_chart_#{chart_type}"
    end
  end
  
  module InstanceMethods
    include HelperMethods
    
    def provide_chart_data
      chart_make = params[:cm]
      chart_type = params[:ct]
      
      chart_type_config, chart_make_version = nil, nil
      if !chart_make.nil? && (chart_make_config = ALaChart::Config[chart_make])
        chart_make_version = chart_make_version || chart_make_config[:default]
        chart_make_config = chart_make_version.nil? ? nil : chart_make_config[chart_make_version.to_sym]
        chart_type_config = chart_make_config.nil? || chart_type.nil? ? nil : chart_make_config[chart_type.to_sym]
      end
      
      return if chart_type_config.nil? || !respond_to?("set_chart_#{chart_type}")
      
      respond_to do |format|
        format.chartxml  { render_style(chart_make, chart_type, chart_make_version, chart_type_config) }
        format.chartjs   { render_style(chart_make, chart_type, chart_make_version, chart_type_config) }
        format.chartjson { render_style(chart_make, chart_type, chart_make_version, chart_type_config) }
      end
    end

  protected

    def render_style(chart_make, chart_type, chart_make_version=nil, chart_type_config=nil)
      if chart_type_config.nil?
        unless !chart_make.nil? && (chart_make_config = ALaChart::Config[chart_make])
          raise "Unknown chart_make. Valid type are: #{ALaChart::Config.keys.map{|v|v.inspect}.join(', ')}"
        end
        
        chart_make_version = chart_make_version || chart_make_config[:default]
        chart_make_config = chart_make_version.nil? ? nil : chart_make_config[chart_make_version.to_sym]
        chart_type_config = chart_make_config.nil? || chart_type.nil? ? {} : chart_make_config[chart_type.to_sym]
      end
      
      data_template = chart_type_config[:data]
      
      send "set_chart_#{chart_type}"
      render File.join(File.dirname(__FILE__), '..', '..', 'configs', chart_make.to_s, chart_make_version.to_s, data_template)
    end
  end
  
  # Check out "included {}" and ActiveSupport::Concern rather than "ClassMethods" - then can
  # "include ALaChart::InstanceMethods" directly in Controllers directly
  # def self.included(base)
  #   base.extend(ClassMethods)
  # end

  module ClassMethods
    
    def a_la_chart
      include ALaChart::InstanceMethods
      
      # TODO: We should ensure this is for inherited_resources
      self.respond_to(:chartxml, :chartjs, :chartjson) if defined?(self.respond_to)
      
      self.before_filter(:provide_chart_data, :only => [:index, :show])
      
      # TODO: Namespace this stuff??
      # :meta, 
      [:before, :data, :value, :set_chart].each do |method|
        # module_eval <<-end_eval
        # master_helper_module.module_eval <<-end_eval
        _helpers.module_eval <<-end_eval
          def #{method}(*args, &block)                    # def data(*args, &block)
            controller.send(%(#{method}), *args, &block)  #   controller.send(%(data), *args, &block)
          end                                             # end
        end_eval
      end
    end
    
    def chart(*types, &block)
      for type in types
        define_method("set_chart_#{type}") do
          block.call if block
        end
      end
    end
    
    def data(*attrs, &block)
      # TODO: make this cooler
      # options = Hash === args.last ? args.pop : {}
      # version = args.last || ">= 0"
      if attrs.size == 1
        attrs = attrs[0]
        if attrs.class == Hash
          options = attrs
        elsif attrs.class == Symbol || attrs.class == String
          cases = [attrs]
        end
      elsif attrs.size > 1
        if attrs[-1].class == Hash
          cases = attrs[0...-1]
          options = attrs[-1]
        else
          cases = attrs[0..-1]
        end
      end
      
      cases ||= []
      options ||= {}
      
      if cases.blank?
        define_method("get_data") do
          do_before_data if defined?(do_before_data)
          # note: instance_eval binds scope variables, call does not
          instance_eval(&block) || []
          # block.call(binding)
        end
        unless options.blank?
          define_method("get_meta") do
            options
          end
        end
      else
        cases.each { |caze|
          define_method("get_data_#{caze}") do
            if respond_to?("do_before_data_#{caze}")
              return [] unless send("do_before_data_#{caze}")
            elsif defined?(do_before_data)
              return [] unless do_before_data
            end
            # note: instance_eval binds scope variables, call does not
            instance_eval(&block) || []
            # block.call(binding)
          end
          define_method("get_meta_#{caze}") do
            options
          end
        }
      end
    end
    
    def before(*cases, &block)
      if cases.blank?
        define_method("do_before_data") do
          # note: instance_eval binds scope variables, call does not
          instance_eval(&block)
          # block.call(binding)
        end
      else
        cases.each { |caze|
          define_method("do_before_data_#{caze}") do
            # note: instance_eval binds scope variables, call does not
            instance_eval(&block)
            # block.call(binding)
          end
        }
      end
    end
    
    # def meta(*attrs)
    #   if attrs.size == 1
    #     attrs = attrs[0]
    #     if attrs.class == Array
    #       descriptions = attrs
    #     elsif attrs.class == Hash
    #       options = attrs
    #     elsif attrs.class == Symbol || attrs.class == String
    #       descriptions = [attrs]
    #     end
    #   elsif attrs.size == 2
    #     descriptions = attrs[0]
    #     if descriptions.class == Symbol || descriptions.class == String
    #       descriptions = [descriptions]
    #     end
    #     options = attrs[1]
    #   elsif attrs.size > 2
    #     descriptions = attrs[0...-1]
    #     options = attrs[-1]
    #   end
    # 
    #   descriptions ||= []
    #   options ||= {}
    # 
    #   # descriptions = descriptions.map{|d| d.to_sym }
    # 
    #   define_method("get_meta") do
    #     # descriptions
    #     options
    #   end
    # end
  end
end
