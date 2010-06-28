# module ALaChart
#   VERSION = '0.1.7'
# end
module ALAChart
  autoload :VERSION, 'a_la_chart/version'
end

require File.join(File.dirname(__FILE__), 'a_la_chart', 'config')
require File.join(File.dirname(__FILE__), 'a_la_chart', 'a_la_chart')
require File.join(File.dirname(__FILE__), 'a_la_chart', 'a_la_chart_helper')

ActionController::Base.class_eval do
  include ALaChart
end
ActionView::Base.send :include, ALaChartHelper

Mime::Type.register "application/xml", :chartxml, %w( text/xml application/x-xml ) unless defined?(Mime::CHARTXML)
Mime::Type.register "text/javascript", :chartjs, %w( application/javascript application/x-javascript ) unless defined?(Mime::CHARTJS)
Mime::Type.register "application/json", :chartjson, %w( text/x-json application/jsonrequest ) unless defined?(Mime::CHARTJSON)
