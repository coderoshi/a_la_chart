xml.pie do
  the_case = params[:case]
  data(the_case).each do |record|
    xml.slice(value(record, :value, the_case), :title => value(record, :label, the_case),
      :url => value(record, :link, the_case),
      :description => value(record, :tooltip, the_case),
      :alpha => color_palette_next(:am, :pie))
  end
end
