class AnalyserClassesController < ApplicationController
  # GET /analyser_classes
  # GET /analyser_classes.json
  def index
    @analyser_classes = AnalyserClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analyser_classes }
    end
  end

  # GET /analyser_classes/1
  # GET /analyser_classes/1.json
  def show
    @analyser_class = AnalyserClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analyser_class }
    end
  end

  # GET /analyser_classes/new
  # GET /analyser_classes/new.json
  def new
    @analyser_class = AnalyserClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @analyser_class }
    end
  end

  # GET /analyser_classes/1/edit
  def edit
    @analyser_class = AnalyserClass.find(params[:id])
  end

  # POST /analyser_classes
  # POST /analyser_classes.json
  def create
    @analyser_class = AnalyserClass.new(params[:analyser_class])

    respond_to do |format|
      if @analyser_class.save
        format.html { redirect_to @analyser_class, notice: 'Analyser class was successfully created.' }
        format.json { render json: @analyser_class, status: :created, location: @analyser_class }
      else
        format.html { render action: "new" }
        format.json { render json: @analyser_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /analyser_classes/1
  # PUT /analyser_classes/1.json
  def update
    @analyser_class = AnalyserClass.find(params[:id])

    respond_to do |format|
      if @analyser_class.update_attributes(params[:analyser_class])
        format.html { redirect_to @analyser_class, notice: 'Analyser class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @analyser_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyser_classes/1
  # DELETE /analyser_classes/1.json
  def destroy
    @analyser_class = AnalyserClass.find(params[:id])
    @analyser_class.destroy

    respond_to do |format|
      format.html { redirect_to analyser_classes_url }
      format.json { head :no_content }
    end
  end
end
