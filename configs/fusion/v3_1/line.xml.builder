xml.chart(chart_options(:fusion, :line).merge(:caption => params[:title])) do
  the_case = params[:case]
  xml.dataset do |dataset|
    data(the_case).each do |set|
      xml.set :value => set
    end
  end
end
