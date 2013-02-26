class ChangeLoggingsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /change_loggings
  # GET /change_loggings.json
  def index
    @change_loggings = ChangeLogging.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @change_loggings }
    end
  end

  # GET /change_loggings/1
  # GET /change_loggings/1.json
  def show
    @change_logging = ChangeLogging.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @change_logging }
    end
  end

  # GET /change_loggings/new
  # GET /change_loggings/new.json
  def new
    @change_logging = ChangeLogging.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @change_logging }
    end
  end

  # GET /change_loggings/1/edit
  def edit
    @change_logging = ChangeLogging.find(params[:id])
  end

  # POST /change_loggings
  # POST /change_loggings.json
  def create
    @change_logging = ChangeLogging.new(params[:change_logging])

    respond_to do |format|
      if @change_logging.save
        format.html { redirect_to @change_logging, notice: 'Change logging was successfully created.' }
        format.json { render json: @change_logging, status: :created, location: @change_logging }
      else
        format.html { render action: "new" }
        format.json { render json: @change_logging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /change_loggings/1
  # PUT /change_loggings/1.json
  def update
    @change_logging = ChangeLogging.find(params[:id])

    respond_to do |format|
      if @change_logging.update_attributes(params[:change_logging])
         changeLogging = ChangeLogging.new(:logRecord => 'Log record updated', :users_id => current_user.id)
         changeLogging.save
        format.html { redirect_to @change_logging, notice: 'Change logging was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @change_logging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /change_loggings/1
  # DELETE /change_loggings/1.json
  def destroy
    @change_logging = ChangeLogging.find(params[:id])
    @change_logging.destroy
    
    changeLogging = ChangeLogging.new(:logRecord => 'Log record deleted', :users_id => current_user.id)
    changeLogging.save

    respond_to do |format|
      format.html { redirect_to change_loggings_url }
      format.json { head :no_content }
    end
  end
  
  def deleteall
    
    ChangeLogging.delete_all
    changeLogging = ChangeLogging.new(:logRecord => 'Log cleared', :users_id => current_user.id)
    changeLogging.save
  end
  
end
