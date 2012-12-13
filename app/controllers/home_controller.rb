class HomeController < ApplicationController
  def index
    
    @test_codes = TestCode.all
    
     
  end
end
