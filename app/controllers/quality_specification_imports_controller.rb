class QualitySpecificationImportsController < ApplicationController
  def new
    @quality_specificaiton_import = QualitySpecificationImport.new
  end

  def create
    @quality_specificaiton_import = QualitySpecificationImport.new(params[:quality_specificaiton_import])
    if @quality_specificaiton_import.save
      redirect_to root_url, notice: "Imported Quality Specificaitons successfully."
    else
      render :new
    end
  end
end