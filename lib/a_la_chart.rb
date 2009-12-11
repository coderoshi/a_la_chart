# module ALaChart
#   VERSION = '0.0.1'
# end
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

ActionController::Base.class_eval do
  include ALaChart
end
ActionView::Base.send :include, ALaChartHelper
