xml.instruct!
xml.chart(chart_options.merge(:upperLimit => params[:upperLimit] || 100, :caption => params[:title])) do
  xml.colorRange do
    xml.color :minValue => '0', :maxValue => '2', :code => 'FF654F'
    xml.color :minValue => '2', :maxValue => '4', :code => 'F6BD0F'
    xml.color :minValue => '4', :maxValue => '5', :code => '8BBA00'
  end
  xml.dials do
    xml.dial :value => value(data, :value)
  end
end
