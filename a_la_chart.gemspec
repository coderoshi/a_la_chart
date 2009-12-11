# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{a_la_chart}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Redmond"]
  s.date = %q{2009-12-11}
  s.description = %q{This is a general framework for inserting various type of charting implementations - from grabbing the data, to declaring how those values are mapped to the desired type of chart (pie, line, bar, etc).}
  s.email = ["eric.redmond@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "MIT-LICENSE", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "configs/fusion/3.0/angular.xml.builder", "configs/fusion/3.0/bar.xml.builder", "configs/fusion/3.0/column.xml.builder", "configs/fusion/3.0/inline.html.erb", "configs/fusion/3.0/line.xml.builder", "configs/fusion/3.0/pie.xml.builder", "configs/fusion/config.yml", "configs/google/1.0/pie.html.erb", "configs/google/config.yml", "configs/raphael/1.2/dot.html.erb", "configs/raphael/1.2/impact.js.erb", "configs/raphael/1.2/inline.html.erb", "configs/raphael/config.yml", "init.rb", "lib/a_la_chart.rb", "lib/a_la_chart/a_la_chart_helper.rb", "lib/a_la_chart/a_la_chart.rb", "script/console", "script/destroy", "script/generate", "test/a_la_chart_test.rb", "test/test_a_la_chart.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/coderoshi/a_la_chart}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{a_la_chart}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{This is a general framework for inserting various type of charting implementations - from grabbing the data, to declaring how those values are mapped to the desired type of chart (pie, line, bar, etc).}
  s.test_files = ["test/test_a_la_chart.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
