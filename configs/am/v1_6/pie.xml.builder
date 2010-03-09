xml.chart(chart_options(:fusion, :pie).merge(:caption => params[:title])) do
  the_case = params[:case]
  data(the_case).each do |record|
    xml.set(:value => value(record, :value, the_case),
      :label => value(record, :label, the_case),
      :link => value(record, :link, the_case),
      :toolText => value(record, :tooltip, the_case),
      :color => color_palette_next(:fusion, :pie))
  end
end
