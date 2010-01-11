module ALaChart
  module Config
    
    # Internally, this config is represented as:
    #  config = {
    #    :fusion => {
    #      :default => :v31,
    #      :v3_1 => {
    #        :format => 'xml',
    #        :pie => {
    #          :data => 'pie.xml.builder',
    #          :chart_type => 'Pie2D',
    #          :remote => 'remote.html.erb',
    #          :inline => 'inline.html.erb'
    #        }
    #      }
    #    }
    #  }
    # Internal configs can be overridden in rails environment configs. For example,
    # to use a custom :inline ERB template (paths are based on RAILS_ROOT):
    # 
    #  ALaChart::Config[:fusion][:v3_1][:pie][:data] = 'app/views/reports/a_la_chart/custom_inline.html.erb'
    # 
    # Then just copy the original template from the gem config dir, and make the desired changes
    def self.config
      unless defined?(@@data)
        require 'yaml'
        
        def self.symbolize_keys!(yaml_data)
          if yaml_data.is_a?(Hash)
            yaml_data.each do |k,v|
              unless k.is_a?(Symbol)
                yaml_data[k.to_sym] ||= yaml_data.delete(k)
              end
              if v.is_a?(Array)
                v.each {|e| self.symbolize_keys!(e) }
              else
                self.symbolize_keys!(v)
              end
            end
          end
        end
        
        @@data = {}
        Dir.foreach(File.join(File.dirname(__FILE__), '..', '..', 'configs')) do |dir|
          config_path = File.join(File.dirname(__FILE__), '..', '..', 'configs', dir, 'config.yml')
          if File.exists?(config_path)
            make = dir.to_sym
            yaml_data = YAML.load_file(config_path)
            # Deep clone the yaml data
            @@data[make] = Marshal::load(Marshal.dump(yaml_data))
            self.symbolize_keys!(@@data[make])
          end
        end
      end
      @@data
    end
    
    def self.[](make)
      self.config[make.to_sym]
    end
    
    def self.keys
      self.config.keys
    end
  end
end
