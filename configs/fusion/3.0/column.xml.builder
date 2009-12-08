xml.instruct!
xml.chart(chart_options.merge(:caption => params[:title])) do
  data.each do |record|
    xml.set :value => value(record, :value), :label => value(record, :label), :link => value(record, :link), :color => next_color
  end
end
