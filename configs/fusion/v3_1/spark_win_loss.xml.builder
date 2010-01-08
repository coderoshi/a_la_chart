xml.instruct!
xml.chart(chart_options.merge(:caption => params[:title])) do
  the_case = params[:case]
  xml.dataset do
    data(the_case).each do |record|
      xml.set :value => value(record, :value, the_case), :label => value(record, :label, the_case), :scoreless => value(record, :scoreless, the_case), :color => next_color
    end
  end
end
