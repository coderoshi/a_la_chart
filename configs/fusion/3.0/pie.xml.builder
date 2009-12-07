xml.instruct!
xml.chart(chart_options) do
  data.each do |record|
    xml.set :value => value(record, :value), :label => value(record, :label), :color => next_color
  end
end
