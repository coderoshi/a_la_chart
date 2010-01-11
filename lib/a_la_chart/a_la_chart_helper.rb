module ALaChartHelper
  require "erb"
  
  def inline_chart_tag(chart_make, chart_style, args={})
    chart_tag(chart_make, chart_style, args.merge(:inline => true))
  end
  
  def chart_tag(chart_make, chart_style, args={})
    width = args[:width] || 400
    height = args[:height] || 300
    chart_make_version = args[:version]
    name = args[:name] || args[:case] || 'chart'
    url = base_url = args[:base_url] || url_for
    
    chart_make = chart_make.to_sym
    
    chart_make_config = ALaChart::Config[chart_make]
    chart_make_version = chart_make_version || chart_make_config[:default]
    chart_make_config = chart_make_config[chart_make_version.to_sym]
    
    chart_type_config = chart_make_config[chart_style.to_sym]
    raise "#{chart_style.to_s} is an unsupported chart style" if chart_type_config.blank?
    inline_template = chart_type_config[:inline]
    remote_template = chart_type_config[:remote]
    
    template = args[:inline] ? inline_template : remote_template || inline_template
    
    data_format = chart_type_config[:format] || chart_make_config[:format]
    
    append_url = chart_type_config[:url] || ".chart#{data_format}"
    url += "#{append_url}?"
    
    explicit_args = args[:args].present? ? params.merge(args[:args]) : params
    args.reject!{ |k,v| [:name,:width,:height,:base_url].include?(k) }
    args.merge!(explicit_args)
    # Can I do this? Or does it make me look like...
    args.reject!{ |k,v| ['action','controller'].include?(k) }
    args[:cm] = chart_make.to_s
    args[:ct] = chart_style.to_s
    
    url += args.to_param
    
    div_id = "#{name}_#{Time.now.to_f.to_s.gsub('.','_')}"
    
    data_template_path = chart_type_config[:data]
    data_template = File.join(File.dirname(__FILE__), '..', '..', 'configs', chart_make.to_s, chart_make_version.to_s, data_template_path) if data_template_path.present?
    # If we cannot find the file, try it as a relative path
    data_template = File.join(RAILS_ROOT, data_template_path) if data_template_path.present? && !File.exists?(data_template) && defined?(RAILS_ROOT)
    
    chart_template = File.join(File.dirname(__FILE__), '..', '..', 'configs', chart_make.to_s, chart_make_version.to_s, template)
    # If we cannot find the file, try it as a relative path
    chart_template = File.join(RAILS_ROOT, template) if !File.exists?(chart_template) && defined?(RAILS_ROOT)
    
    chart_template_erb = ERB.new(File.read(chart_template))
    chart_template_erb.result(binding)
  end
  
  # TODO: REMOVE all of this stuff... make this all external configurations
  def color_palette
    ["7BB465","B2B4B6","FEC35A","65A4B5","9E65B5","B57765","F7DF65","8F866C","B6A65F","C99D60","C1727A","8AABB9","65B584"]
  end

  def next_color
    @colors ||= color_palette
    @colors.pop
  end

  def chart_options
    {
      :animation => '1',
      :showBorder => '0',
      :canvasBorderThickness => '1',
      :canvasBorderColor => 'eeeeee',
      :divLineThickness => '1',
      :bgAlpha => '0',
      :useRoundEdges => '0',
      :alpha => '100',
      :bgColor => 'ffffff',
      :shadowXShift=>"1",
      :shadowYShift=>"1",
      :shadowAlpha=>"75",
      # :numberprefix => '$',
      :showValues => '0',
      :showSum => '1',
      :enableSmartLabels => '1',
      :skipOverlapLabels => '1',
      :decimalPrecision => "2",
      :captionPadding => '3',
      :chartLeftMargin => '0',
      :formatNumber => '1',
      :formatNumberScale => '0',
      :baseFont => 'Helvetica, Arial, sans-serif',
      :baseFontSize => '11',
      :baseFontColor => '515151',
      :showToolTip => '1',
      :toolTipBgColor => 'ffffff'
    }
  end
  
end