class AnalyserTypesController < ApplicationController
  # GET /analyser_types
  # GET /analyser_types.json
  def index
    @analyser_types = AnalyserType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analyser_types }
    end
  end

  # GET /analyser_types/1
  # GET /analyser_types/1.json
  def show
    @analyser_type = AnalyserType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analyser_type }
    end
  end

  # GET /analyser_types/new
  # GET /analyser_types/new.json
  def new
    @analyser_type = AnalyserType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @analyser_type }
    end
  end

  # GET /analyser_types/1/edit
  def edit
    @analyser_type = AnalyserType.find(params[:id])
  end

  # POST /analyser_types
  # POST /analyser_types.json
  def create
    @analyser_type = AnalyserType.new(params[:analyser_type])

    respond_to do |format|
      if @analyser_type.save
        format.html { redirect_to @analyser_type, notice: 'Analyser type was successfully created.' }
        format.json { render json: @analyser_type, status: :created, location: @analyser_type }
      else
        format.html { render action: "new" }
        format.json { render json: @analyser_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /analyser_types/1
  # PUT /analyser_types/1.json
  def update
    @analyser_type = AnalyserType.find(params[:id])

    respond_to do |format|
      if @analyser_type.update_attributes(params[:analyser_type])
        format.html { redirect_to @analyser_type, notice: 'Analyser type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @analyser_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyser_types/1
  # DELETE /analyser_types/1.json
  def destroy
    @analyser_type = AnalyserType.find(params[:id])
    @analyser_type.destroy

    respond_to do |format|
      format.html { redirect_to analyser_types_url }
      format.json { head :no_content }
    end
  end
end
