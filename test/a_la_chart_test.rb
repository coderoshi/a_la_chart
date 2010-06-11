# require 'test_helper'
require File.join('/Users/eredmond/Code/a_la_chart', File.dirname(__FILE__), 'test_helper.rb')
# require File.join(File.dirname(__FILE__), 'test_helper.rb')
require 'active_support/core_ext/object/to_query'

class Person
  extend ActiveModel::Naming
end

class PeopleController < ActionController::Base
  a_la_chart
  
  chart :pie do
    data(:label => :city, :value => :total) do
      # Person.all(:select => 'city, COUNT(people.*) as total', :group => 'city')
      [
        Person.new(:city => 'Vegas', :total => 5),
        Person.new(:city => 'Baltimore', :total => 8),
        Person.new(:city => 'Indianapolis', :total => 6)
      ]
    end
  end
  
  def index
  end
end

# ALaChartTest

class BasicTest < ActionController::TestCase
  def setup
    @controller          = PeopleController.new
    @controller.request  = @request  = ActionController::TestRequest.new
    @controller.response = @response = ActionController::TestResponse.new
    @controller.stubs(:people_url).returns("/")
  end
  
  test "the truth" do
    get :index
    @controller.set_chart(:pie)
    p @controller.data
  end
end
