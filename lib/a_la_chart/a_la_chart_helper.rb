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
    
    div_id = "#{name}#{Time.now.to_f.to_s.gsub('.','')}"
    
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
  
  def color_palette(chart_make, chart_style=nil)
    theme(chart_make)[:color_palette] || []
  end
  
  def color_palette_clear(chart_make, chart_style=nil)
    @color_palette_ary = color_palette(chart_make, chart_style).clone
  end
  
  def color_palette_next(chart_make, chart_style=nil)
    @color_palette_ary ||= color_palette(chart_make, chart_style).clone
    @color_palette_ary.pop
  end
  
  # Merge with per-chart options
  def chart_options(chart_make, chart_style=nil)
    theme(chart_make)[:default_options] || {}
  end
  
private
  
  def theme_name(chart_make)
    ALaChart::Config[chart_make][:theme]
  end
  
  def theme(chart_make)
    ALaChart::Config[chart_make][:themes][theme_name(chart_make)] || {}
  end
  
end