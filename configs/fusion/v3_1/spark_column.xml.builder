xml.chart(chart_options(:fusion, :spark_column).merge(:caption => params[:title])) do
  the_case = params[:case]
  xml.dataset do
    data(the_case).each do |record|
      xml.set :value => value(record, :value, the_case)
    end
  end
end
