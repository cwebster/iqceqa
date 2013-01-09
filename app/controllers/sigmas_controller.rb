class SigmasController < ApplicationController
  # GET /sigmas
  # GET /sigmas.json
  def index
    @sigmas = Sigma.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sigmas }
    end
  end

  # GET /sigmas/1
  # GET /sigmas/1.json
  def show
    @sigma = Sigma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sigma }
    end
  end

  # GET /sigmas/new
  # GET /sigmas/new.json
  def new
    @sigma = Sigma.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sigma }
    end
  end

  # GET /sigmas/1/edit
  def edit
    @sigma = Sigma.find(params[:id])
  end

  # POST /sigmas
  # POST /sigmas.json
  def create
    @sigma = Sigma.new(params[:sigma])

    respond_to do |format|
      if @sigma.save
        format.html { redirect_to @sigma, notice: 'Sigma was successfully created.' }
        format.json { render json: @sigma, status: :created, location: @sigma }
      else
        format.html { render action: "new" }
        format.json { render json: @sigma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sigmas/1
  # PUT /sigmas/1.json
  def update
    @sigma = Sigma.find(params[:id])

    respond_to do |format|
      if @sigma.update_attributes(params[:sigma])
        format.html { redirect_to @sigma, notice: 'Sigma was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sigma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sigmas/1
  # DELETE /sigmas/1.json
  def destroy
    @sigma = Sigma.find(params[:id])
    @sigma.destroy

    respond_to do |format|
      format.html { redirect_to sigmas_url }
      format.json { head :no_content }
    end
  end
  
  def checkLastCalculationDate
  	@calculationDate = ChangeLogging.find(:last, :order => "created_at ASC", :conditions => [ "logRecord = ?", 'QC'])
  	
  	@iqcs = IqcDatum.where("dateTimeCreated > ?", @calculationDate.created_at)
  	
  	
  	
  	respond_to do |format|
  	  format.html # index.html.erb
  	  format.json { head :no_content  }
  	end
  
  end
  
  
  
  
end
