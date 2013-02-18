class FormConfigsController < ApplicationController
  # GET /form_configs
  # GET /form_configs.json
  def index
    @form_configs = FormConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @form_configs }
    end
  end

  # GET /form_configs/1
  # GET /form_configs/1.json
  def show
    @form_config = FormConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @form_config }
    end
  end

  # GET /form_configs/new
  # GET /form_configs/new.json
  def new
    @form_config = FormConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form_config }
    end
  end

  # GET /form_configs/1/edit
  def edit
    @form_config = FormConfig.find(params[:id])
  end

  # POST /form_configs
  # POST /form_configs.json
  def create
    @form_config = FormConfig.new(params[:form_config])

    respond_to do |format|
      if @form_config.save
        format.html { redirect_to @form_config, notice: 'Form config was successfully created.' }
        format.json { render json: @form_config, status: :created, location: @form_config }
      else
        format.html { render action: "new" }
        format.json { render json: @form_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /form_configs/1
  # PUT /form_configs/1.json
  def update
    @form_config = FormConfig.find(params[:id])

    respond_to do |format|
      if @form_config.update_attributes(params[:form_config])
        format.html { redirect_to @form_config, notice: 'Form config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @form_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_configs/1
  # DELETE /form_configs/1.json
  def destroy
    @form_config = FormConfig.find(params[:id])
    @form_config.destroy

    respond_to do |format|
      format.html { redirect_to form_configs_url }
      format.json { head :no_content }
    end
  end
  
  def create_form
    debugger
    @form_configs = FormConfig.where(:form_builder_id => params[:form_builder_id]).all
    
    @form_builder_details = FormBuilder.find(@form_configs[0].form_builder_id)
    
     respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @form_config }
      end
  
  end
  
  
end
