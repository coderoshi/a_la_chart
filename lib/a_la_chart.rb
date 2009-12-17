module ALaChart
  VERSION = '0.0.2'
end

require File.join(File.dirname(__FILE__), 'a_la_chart', 'a_la_chart')
require File.join(File.dirname(__FILE__), 'a_la_chart', 'a_la_chart_helper')

ActionController::Base.class_eval do
  include ALaChart
end
ActionView::Base.send :include, ALaChartHelper
