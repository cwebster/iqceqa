class EqaSchemesController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /eqa_schemes
  # GET /eqa_schemes.json
  def index
    @eqa_schemes = EqaScheme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eqa_schemes }
    end
  end

  # GET /eqa_schemes/1
  # GET /eqa_schemes/1.json
  def show
    @eqa_scheme = EqaScheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eqa_scheme }
    end
  end

  # GET /eqa_schemes/new
  # GET /eqa_schemes/new.json
  def new
    @eqa_scheme = EqaScheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eqa_scheme }
    end
  end

  # GET /eqa_schemes/1/edit
  def edit
    @eqa_scheme = EqaScheme.find(params[:id])
  end

  # POST /eqa_schemes
  # POST /eqa_schemes.json
  def create
    @eqa_scheme = EqaScheme.new(params[:eqa_scheme])

    respond_to do |format|
      if @eqa_scheme.save
        
        @eqa_scheme.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'EQA scheme created', :users_id => current_user.id)
        changeLogging.save
        
        format.html { redirect_to @eqa_scheme, notice: 'Eqa scheme was successfully created.' }
        format.json { render json: @eqa_scheme, status: :created, location: @eqa_scheme }
      else
        format.html { render action: "new" }
        format.json { render json: @eqa_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eqa_schemes/1
  # PUT /eqa_schemes/1.json
  def update
    @eqa_scheme = EqaScheme.find(params[:id])

    respond_to do |format|
      if @eqa_scheme.update_attributes(params[:eqa_scheme])
        format.html { redirect_to @eqa_scheme, notice: 'Eqa scheme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eqa_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eqa_schemes/1
  # DELETE /eqa_schemes/1.json
  def destroy
    @eqa_scheme = EqaScheme.find(params[:id])
    @eqa_scheme.destroy

    respond_to do |format|
      format.html { redirect_to eqa_schemes_url }
      format.json { head :no_content }
    end
  end
end
