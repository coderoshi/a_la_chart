opts = chart_options(:amc, :pie)
xml.pie do
  the_case = params[:case]
  data(the_case).each do |record|
    xml.slice(value(record, :value, the_case), :title => value(record, :label, the_case),
      :url => value(record, :link, the_case),
      :description => value(record, :description, the_case),
      :color => color_palette_next(:amc, :pie),
      :pattern => opts[:pattern],
      :pattern_color => opts[:pattern_color],
      :alpha => opts[:alpha],
      :pull_out => value(record, :pull_out, the_case),
      :label_radius => value(record, :label_radius, the_case))
  end
end
