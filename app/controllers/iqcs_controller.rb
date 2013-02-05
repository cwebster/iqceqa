class IqcsController < ApplicationController
  
  before_filter :authenticate_user!
  
  
# GET /iqc
  # GET /iqc.json
  def index
    @iqc = Iqc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @iqc }
    end
  end

  # GET /iqc/1
  # GET /iqc/1.json
  def show
    @iqc = Iqc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @iqc }
    end
  end

  # GET /iqc/new
  # GET /iqc/new.json
  def new
    @iqc = Iqc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @iqc }
    end
  end

  # GET /iqc/1/edit
  def edit
    @iqc = Iqc.find(params[:id])
  end

  # POST /iqc
  # POST /iqc.json
  def create
    @iqc = Iqc.new(params[:iqc])

    respond_to do |format|
      if @iqc.save
        @iqc.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'QC Material Created', :users_id => current_user.id)
        changeLogging.save
        
        format.html { redirect_to @iqc, notice: 'IQC was successfully created.' }
        format.json { render json: @iqc, status: :created, location: @iqc }
      else
        format.html { render action: "new" }
        format.json { render json: @iqc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /iqc/1
  # PUT /iqc/1.json
  def update
    @iqc = Iqc.find(params[:id])

    respond_to do |format|
      if @iqc.update_attributes(params[:iqc])
        format.html { redirect_to @iqc, notice: 'IQC was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @iqc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iqc/1
  # DELETE /iqc/1.json
  def destroy
    @iqc = Iqc.find(params[:id])
    @iqc.destroy

    respond_to do |format|
      format.html { redirect_to iqc_url }
      format.json { head :no_content }
    end
  end
end
