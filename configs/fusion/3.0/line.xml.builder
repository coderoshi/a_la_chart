xml.instruct!
xml.chart(chart_options.merge(:caption => params[:title])) do
  xml.dataset do |dataset|
    data.each do |set|
      xml.set :value => set
    end
  end
end
