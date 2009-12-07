xml.instruct!
xml.chart(chart_options) do
  xml.dataset do |dataset|
    data.each do |set|
      xml.set :value => set
    end
  end
end
