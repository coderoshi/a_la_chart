xml.chart(chart_options(:fusion, :spark_win_loss).merge(:caption => params[:title])) do
  the_case = params[:case]
  xml.dataset do
    data(the_case).each do |record|
      xml.set(:value => value(record, :value, the_case),
        :label => value(record, :label, the_case),
        :scoreless => value(record, :scoreless, the_case),
        :color => color_palette_next(:fusion, :spark_win_loss))
    end
  end
end
