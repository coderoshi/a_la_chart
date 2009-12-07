class ActionController::Base

  # Pair with inherit_resources to allow :action/:chart.xml behavior to function
  # TODO: This whole line of attack feels like a hack - is there a way to extract
  # certain keywords from the IR association_chain? Or is that a bad idea too? - eredmond
  def self.inherit_resources_chart
    self.class_eval do
      def show
        show! { |format|
          format.xml { render_style params[:chart_make], params[:id] } 
          format.js { render_style params[:chart_make], params[:id] }
        }
      end
      
    protected
      
      # TODO: chain this method. grab the params[:id], and if it is a 
      # string matching one of the valid chart types
      def resource
        nil
      end
      
      # XXX: how can we use the ALaChart::InstanceMethods.render_style ?
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
  end
end
