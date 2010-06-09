require 'test_helper'

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
#   respond_to :html, :xml
#   respond_to :js, :only => [:create, :update, :destroy]
#   attr_reader :scopes_applied
# 
# protected
# 
#   def apply_scopes(object)
#     @scopes_applied = true
#     object
#   end
end

class BasicTest < ActionController::TestCase
  def setup
    @controller          = PeopleController.new
    @controller.request  = @request  = ActionController::TestRequest.new
    # def @request.to_query; {}; end
    @controller.response = @response = ActionController::TestResponse.new
    @controller.stubs(:people_url).returns("/")
  end
  
  test "the truth" do
    get :index
    # assert true
  end
end
# class ALaChartTest < ActiveSupport::TestCase
#   # Replace this with your real tests.
#   test "the truth" do
#     assert true
#   end
# end
