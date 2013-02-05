class TestCodeImportsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @test_code_import = TestCodeImport.new
  end

  def create
    @test_code_import = TestCodeImport.new(params[:test_codes_import])
    if @test_code_import.save
      redirect_to root_url, notice: "Imported Test Codes successfully."
    else
      render :new
    end
  end
end