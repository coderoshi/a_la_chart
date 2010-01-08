xml.instruct!
xml.chart(chart_options.merge(:caption => params[:title])) do
  the_case = params[:case]
  data(the_case).each do |record|
    xml.set :value => value(record, :value, the_case), :label => value(record, :label, the_case), :link => value(record, :link, the_case), :color => next_color
  end
end
