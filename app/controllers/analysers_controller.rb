class AnalysersController < ApplicationController
  
  before_filter :authenticate_user!
  
	# GET /analysers
  # GET /analysers.json
  def index
    @analysers = Analyser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analysers }
    end
  end

  # GET /analysers/1
  # GET /analysers/1.json
  def show
    @analysers = Analyser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analysers }
    end
  end

  # GET /analysers/new
  # GET /analysers/new.json
  def new
    @analysers = Analyser.new
   

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @analysers }
    end
  end

  # GET /analysers/1/edit
  def edit
    @analysers = Analyser.find(params[:id])
  end

  # POST /analysers
  # POST /analysers.json
  def create
    @analysers = Analyser.new(params[:analyser])

    respond_to do |format|
      if @analysers.save
        changeLogging = ChangeLogging.new(:logRecord => 'New analyser created', :users_id => current_user.id)
        changeLogging.save
        
        format.html { redirect_to @analysers, notice: 'analysers was successfully created.' }
        format.json { render json: @analysers, status: :created, location: @analysers }
      else
        format.html { render action: "new" }
        format.json { render json: @analysers.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /analysers/1
  # PUT /analysers/1.json
  def update
    @analysers = Analyser.find(params[:id])

    respond_to do |format|
      if @analysers.update_attributes(params[:analyser])
        changeLogging = ChangeLogging.new(:logRecord => 'Analyser updated' + params[:analyser], :users_id => current_user.id)
        changeLogging.save
        
        format.html { redirect_to @analysers, notice: 'analysers was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @analysers.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analysers/1
  # DELETE /analysers/1.json
  def destroy
    @analysers = Analyser.find(params[:id])
    @analysers.destroy
    
    changeLogging = ChangeLogging.new(:logRecord => 'Analyser deleted' + params[:id], :users_id => current_user.id)
    changeLogging.save

    respond_to do |format|
      format.html { redirect_to analysers_url }
      format.json { head :no_content }
    end
  end
end
