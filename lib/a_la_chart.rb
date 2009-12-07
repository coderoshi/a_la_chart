module ALaChart
  
  module HelperMethods
    def meta
      @metadata ||= defined?(get_meta) ? get_meta : {}
    end

    def fields
      @fields ||= defined?(get_fields) ? get_fields : []
    end
  
    def data
      @data ||= defined?(get_data) ? get_data : []
    end
  
    def value(object, key)
      return '' if object.blank?
    
      # if there is a meta map, use it. else try the key itself
      key_field = meta[key] || key
    
      if key_field.class == Proc
        val = key_field.call(object)
      else
        val = object.respond_to?(key_field) ? object.send(key_field) : nil
        val = object[key_field] if object.respond_to?('[]')
        val
      end
    end
    
    def set_chart(chart_type)
      send "set_chart_#{chart_type}"
    end
    
    def a_la_chart_config
      unless defined?(@@alachart_config)
        require 'yaml'
        
        @@alachart_config = {}
        Dir.foreach(File.join(File.dirname(__FILE__), '..', 'configs')) do |dir|
          config_path = File.join(File.dirname(__FILE__), '..', 'configs', dir, 'config.yml')
          if File.exists?(config_path)
            @@alachart_config[dir.to_sym] = YAML.load_file(config_path)
          end
        end
      end
      @@alachart_config
    end
  end
  
  module InstanceMethods
    include HelperMethods
    
    def show
      respond_to do |format|
        # format.html # index.html.erb
        format.xml { render_style params[:chart_make], params[:id] }
        format.js { render_style params[:chart_make], params[:id] }
      end
    end

  protected

    def render_style(chart_make, chart_type, chart_make_version=nil)
      chart_make = chart_make.to_sym
      
      chart_make_config = a_la_chart_config[chart_make]
      chart_make_version = chart_make_version || chart_make_config['default']
      chart_make_config = chart_make_config[chart_make_version]
      chart_type_config = chart_make_config[chart_type.to_s]
      data_template = chart_type_config['data']
      
      send "set_chart_#{chart_type}"
      render File.join(File.dirname(__FILE__), '..', 'configs', chart_make.to_s, chart_make_version.to_s, data_template)
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def a_la_chart
      require 'inherit_resources_chart'
      
      # a_la_chart_config
      
      include ALaChart::InstanceMethods
      
      # Namespace this stuff??
      [:data, :fields, :meta, :value, :a_la_chart_config, :set_chart].each do |method|
        master_helper_module.module_eval <<-end_eval
          def #{method}(*args, &block)                    # def current_user(*args, &block)
            controller.send(%(#{method}), *args, &block)  #   controller.send(%(current_user), *args, &block)
          end                                             # end
        end_eval
      end
    end
    
    # def a_la_chart_config
    #   unless defined?(@@alachart_config)
    #     require 'yaml'
    #     
    #     @@alachart_config = {}
    #     Dir.foreach(File.join(File.dirname(__FILE__), '..', 'configs')) do |dir|
    #       config_path = File.join(File.dirname(__FILE__), '..', 'configs', dir, 'config.yml')
    #       if File.exists?(config_path)
    #         @@alachart_config[dir.to_sym] = YAML.load_file(config_path)
    #       end
    #     end
    #   end
    #   @@alachart_config
    # end
    
    def chart(*types, &block)
      for type in types
        define_method("set_chart_#{type}") do
          block.call if block
        end
      end
    end
  
    def data(&block)
      define_method("get_data") do
        # note: instance_eval binds scope variables, call does not
        instance_eval(&block) || []
        # block.call(binding)
      end
    end
  
    def fields(*attrs)
      field_ary = attrs.map{|d| d.to_sym }
    
      define_method("get_fields") do
        field_ary
      end
    end
  
    def meta(*attrs)
      if attrs.size == 1
        attrs = attrs[0]
        if attrs.class == Array
          descriptions = attrs
        elsif attrs.class == Hash
          options = attrs
        elsif attrs.class == Symbol || attrs.class == String
          descriptions = [attrs]
        end
      elsif attrs.size == 2
        descriptions = attrs[0]
        if descriptions.class == Symbol || descriptions.class == String
          descriptions = [descriptions]
        end
        options = attrs[1]
      elsif attrs.size > 2
        descriptions = attrs[0...-1]
        options = attrs[-1]
      end
    
      descriptions ||= []
      options ||= {}
    
      # descriptions = descriptions.map{|d| d.to_sym }
    
      define_method("get_meta") do
        # descriptions
        options
      end
    end
  end
end
