xml.chart(chart_options(:fusion, :angular).merge(:upperLimit => params[:upperLimit] || 100, :caption => params[:title])) do
  the_case = params[:case]
  xml.colorRange do
    xml.color :minValue => '0', :maxValue => '2', :code => 'FF654F'
    xml.color :minValue => '2', :maxValue => '4', :code => 'F6BD0F'
    xml.color :minValue => '4', :maxValue => '5', :code => '8BBA00'
  end
  xml.dials do
    xml.dial :value => value(data, :value, the_case)
  end
end
