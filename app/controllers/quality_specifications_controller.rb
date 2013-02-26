class QualitySpecificationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  # GET /quality_specifications
  # GET /quality_specifications.json
  def index
    @quality_specifications = QualitySpecification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quality_specifications }
      format.csv { send_data QualitySpecification.to_csv }
      format.xls # { send_data @quality_specifications.to_csv(col_sep: "\t")}
    end
  end

  # GET /quality_specifications/1
  # GET /quality_specifications/1.json
  def show
    @quality_specification = QualitySpecification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quality_specification }
    end
  end

  # GET /quality_specifications/new
  # GET /quality_specifications/new.json
  def new
    @quality_specification = QualitySpecification.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quality_specification }
    end
  end

  # GET /quality_specifications/1/edit
  def edit
    @quality_specification = QualitySpecification.find(params[:id])
  end

  # POST /quality_specifications
  # POST /quality_specifications.json
  def create
    @quality_specification = QualitySpecification.new(params[:quality_specification])

    respond_to do |format|
      if @quality_specification.save
        @quality_specification.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'Quality Specification Entered', :users_id => current_user.id)
        changeLogging.save
        
        
        format.html { redirect_to @quality_specification, notice: 'Quality specification was successfully created.' }
        format.json { render json: @quality_specification, status: :created, location: @quality_specification }
      else
        format.html { render action: "new" }
        format.json { render json: @quality_specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quality_specifications/1
  # PUT /quality_specifications/1.json
  def update
    @quality_specification = QualitySpecification.find(params[:id])

    respond_to do |format|
      if @quality_specification.update_attributes(params[:quality_specification])
        
        @quality_specification.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'Quality Specificaiton Updated', :users_id => current_user.id)
        changeLogging.save
        
        
        format.html { redirect_to @quality_specification, notice: 'Quality specification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quality_specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quality_specifications/1
  # DELETE /quality_specifications/1.json
  def destroy
    @quality_specification = QualitySpecification.find(params[:id])
    @quality_specification.destroy
    
    changeLogging = ChangeLogging.new(:logRecord => 'Quality Specification deleted' + params[:id], :users_id => current_user.id)
    changeLogging.save

    respond_to do |format|
      format.html { redirect_to quality_specifications_url }
      format.json { head :no_content }
    end
  end
  
  def import
  	QualitySpecification.import(params[:file])
  	changeLogging = ChangeLogging.new(:logRecord => 'Quality Specifications imported', :users_id => current_user.id)
    changeLogging.save
  	redirect_to root_url, notice: "Quality specifications imported."
  end
  
  
end
