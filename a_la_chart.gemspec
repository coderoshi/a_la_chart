# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{a_la_chart}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Redmond"]
  s.date = %q{2010-06-28}
  s.description = %q{A framework for managing various types of charting implementations.}
  s.email = %q{eric.redmond@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "History.txt",
     "MIT-LICENSE",
     "Manifest.txt",
     "README.rdoc",
     "Rakefile",
     "configs/amc/config.yml",
     "configs/amc/v1_6/inline.html.erb",
     "configs/amc/v1_6/pie.xml.builder",
     "configs/amc/v1_6/remote.html.erb",
     "configs/fusion/config.yml",
     "configs/fusion/v3_1/angular.xml.builder",
     "configs/fusion/v3_1/bar.xml.builder",
     "configs/fusion/v3_1/bullet.xml.builder",
     "configs/fusion/v3_1/column.xml.builder",
     "configs/fusion/v3_1/funnel.xml.builder",
     "configs/fusion/v3_1/inline.html.erb",
     "configs/fusion/v3_1/line.xml.builder",
     "configs/fusion/v3_1/pie.xml.builder",
     "configs/fusion/v3_1/pyramid.xml.builder",
     "configs/fusion/v3_1/remote.html.erb",
     "configs/fusion/v3_1/spark_column.xml.builder",
     "configs/fusion/v3_1/spark_line.xml.builder",
     "configs/fusion/v3_1/spark_win_loss.xml.builder",
     "configs/fusion/v3_1/stacked_column.xml.builder",
     "configs/google/config.yml",
     "configs/google/v1_0/interactive.html.erb",
     "configs/google/v1_0/pie.html.erb",
     "configs/graphael/config.yml",
     "configs/graphael/v1_2/dot.html.erb",
     "configs/graphael/v1_2/impact.js.erb",
     "configs/graphael/v1_2/inline.html.erb",
     "init.rb",
     "lib/a_la_chart.rb",
     "lib/a_la_chart/a_la_chart.rb",
     "lib/a_la_chart/a_la_chart_helper.rb",
     "lib/a_la_chart/config.rb",
     "lib/a_la_chart/version.rb"
  ]
  s.homepage = %q{http://github.com/coderoshi/a_la_chart}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{a_la_chart}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{a La Chart manages various types of charting implementations - from grabbing the data, to declaring how those values are mapped to the desired type of chart (pie, line, bar, etc).}
  s.test_files = [
    "test/a_la_chart_test.rb",
     "test/test_a_la_chart.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<responders>, ["~> 0.6.0"])
      s.add_runtime_dependency(%q<has_scope>, ["~> 0.5.0"])
    else
      s.add_dependency(%q<responders>, ["~> 0.6.0"])
      s.add_dependency(%q<has_scope>, ["~> 0.5.0"])
    end
  else
    s.add_dependency(%q<responders>, ["~> 0.6.0"])
    s.add_dependency(%q<has_scope>, ["~> 0.5.0"])
  end
end

