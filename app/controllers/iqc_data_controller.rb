class IqcDataController < ApplicationController
  # GET /iqc_data
  # GET /iqc_data.json
  def index
    @iqc_data = IqcDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @iqc_data }
    end
  end

  # GET /iqc_data/1
  # GET /iqc_data/1.json
  def show
    @iqc_datum = IqcDatum.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @iqc_datum }
    end
  end

  # GET /iqc_data/new
  # GET /iqc_data/new.json
  def new
    @iqc_datum = IqcDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @iqc_datum }
    end
  end

  # GET /iqc_data/1/edit
  def edit
    @iqc_datum = IqcDatum.find(params[:id])
  end

  # POST /iqc_data
  # POST /iqc_data.json
  def create
    @iqc_datum = IqcDatum.new(params[:iqc_datum])

    respond_to do |format|
      if @iqc_datum.save
        format.html { redirect_to @iqc_datum, notice: 'Iqc datum was successfully created.' }
        format.json { render json: @iqc_datum, status: :created, location: @iqc_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @iqc_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /iqc_data/1
  # PUT /iqc_data/1.json
  def update
    @iqc_datum = IqcDatum.find(params[:id])

    respond_to do |format|
      if @iqc_datum.update_attributes(params[:iqc_datum])
        format.html { redirect_to @iqc_datum, notice: 'Iqc datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @iqc_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iqc_data/1
  # DELETE /iqc_data/1.json
  def destroy
    @iqc_datum = IqcDatum.find(params[:id])
    @iqc_datum.destroy

    respond_to do |format|
      format.html { redirect_to iqc_data_url }
      format.json { head :no_content }
    end
  end
end
