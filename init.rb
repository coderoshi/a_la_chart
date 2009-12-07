ActionController::Base.class_eval do
  include ALaChart
end
ActionView::Base.send :include, ALaChartHelper
