class QualitySpecificationImportsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @quality_specification_import = QualitySpecificationImport.new
  end

  def create
    @quality_specification_import = QualitySpecificationImport.new(params[:quality_specification_import])
    if @quality_specification_import.save
      redirect_to root_url, notice: "Imported Quality Specificaitons successfully."
    else
      render :new
    end
  end
end