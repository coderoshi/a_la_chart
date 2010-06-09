# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{a_la_chart}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Redmond"]
  s.date = %q{2010-2-22}
  s.description = %q{This is a general framework for inserting various types of charting implementations - from grabbing the data, to declaring how those values are mapped to the desired type of chart (pie, line, bar, etc).}
  s.email = ["eric.redmond@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "MIT-LICENSE", "Manifest.txt", "README.rdoc", "Rakefile", "configs/fusion/v3_1/angular.xml.builder", "configs/fusion/v3_1/bar.xml.builder", "configs/fusion/v3_1/bullet.xml.builder", "configs/fusion/v3_1/column.xml.builder", "configs/fusion/v3_1/funnel.xml.builder", "configs/fusion/v3_1/remote.html.erb", "configs/fusion/v3_1/inline.html.erb", "configs/fusion/v3_1/line.xml.builder", "configs/fusion/v3_1/pie.xml.builder", "configs/fusion/v3_1/pyramid.xml.builder", "configs/fusion/v3_1/spark_column.xml.builder", "configs/fusion/v3_1/spark_line.xml.builder", "configs/fusion/v3_1/spark_win_loss.xml.builder", "configs/fusion/v3_1/stacked_column.xml.builder", "configs/fusion/config.yml", "configs/google/v1_0/pie.html.erb", "configs/google/config.yml", "configs/graphael/v1_2/dot.html.erb", "configs/graphael/v1_2/impact.js.erb", "configs/graphael/v1_2/inline.html.erb", "configs/graphael/config.yml", "configs/am/config.yml", "configs/am/v1_6/inline.html.erb", "configs/am/v1_6/remote.html.erb", "configs/am/v1_6/pie.xml.builder", "init.rb", "lib/a_la_chart.rb", "lib/a_la_chart/a_la_chart_helper.rb", "lib/a_la_chart/a_la_chart.rb", "lib/a_la_chart/config.rb", "script/console", "script/destroy", "script/generate", "test/a_la_chart_test.rb", "test/test_a_la_chart.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/coderoshi/a_la_chart}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{a_la_chart}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A framework for managing various types of charting implementations.}
  s.test_files = ["test/test_a_la_chart.rb", "test/test_helper.rb"]

  # if s.respond_to? :specification_version then
  #   current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
  #   s.specification_version = 3
  # 
  #   if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
  #     s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
  #   else
  #     s.add_dependency(%q<hoe>, [">= 2.3.3"])
  #   end
  # else
  #   s.add_dependency(%q<hoe>, [">= 2.3.3"])
  # end
end
