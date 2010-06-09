xml.chart(chart_options(:fusion, :stacked_column).merge(:caption => params[:title], :showLegend => '0')) do
  the_case = params[:case]
  xml.categories do
    data(the_case).map{|record| value(record, :label, the_case) }.uniq.compact.each do |label|
      xml.category :label => label
    end
  end
  data_by_category = {}
  data(the_case).each do |record|
    (data_by_category[value(record, :category, the_case)] ||= []) << record
  end
  data_by_category.each do |category, records|
    xml.dataset(:seriesName => category, :color => value(records.first, :color, the_case) || color_palette_next(:fusion, :stacked_column)) do
      records.each do |record|
        xml.set :value => value(record, :value, the_case), :toolText => "#{category}, #{value(record, :value, the_case)}"
      end
    end
  end
end
