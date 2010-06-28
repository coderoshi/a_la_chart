# encoding: UTF-8

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'a_la_chart', 'version')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "a_la_chart"
    s.version = ALaChart::VERSION.dup
    s.rubyforge_project = "a_la_chart"
    s.summary = "a La Chart manages various types of charting implementations - from grabbing the data, to declaring how those values are mapped to the desired type of chart (pie, line, bar, etc)."
    s.email = "eric.redmond@gmail.com"
    s.homepage = "http://github.com/coderoshi/a_la_chart"
    s.description = "A framework for managing various types of charting implementations."
    s.authors = ['Eric Redmond']
    s.files =  FileList["[A-Z]*", "init.rb", "{lib}/**/*", "configs/**/*"]
    s.add_dependency("responders", "~> 0.6.0")
    s.add_dependency("has_scope",  "~> 0.5.0")
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end

desc 'Run tests for ALaChart.'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for ALaChart.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ALaChart'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


# require 'rubygems'
# gem 'hoe', '>= 2.1.0'
# require 'hoe'
# require 'fileutils'
# # require './lib/a_la_chart'
# 
# Hoe.plugin :newgem
# # Hoe.plugin :website
# # Hoe.plugin :cucumberfeatures
# 
# # Generate all the Rake tasks
# # Run 'rake -T' to see list of generated tasks (from gem root directory)
# $hoe = Hoe.spec 'a_la_chart' do
#   self.developer 'Eric Redmond', 'eric.redmond@gmail.com'
#   self.rubyforge_name       = self.name # TODO this is default value
#   # self.extra_deps         = [['activesupport','>= 2.0.2']]
# 
# end
# 
# # require 'newgem/tasks'
# # Dir['tasks/**/*.rake'].each { |t| load t }
# 
# # TODO - want other tests/tasks run by default? Add them to the list
# # remove_task :default
# # task :default => [:spec, :features]
