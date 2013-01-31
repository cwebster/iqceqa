class EqasController < ApplicationController
  # GET /eqas
  # GET /eqas.json
  def index
    @eqas = Eqa.all
    @eqas_by_date = @eqas.group_by{ |item| item.dateOfEQA.to_date }
    
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eqas }
    end
  end

  # GET /eqas/1
  # GET /eqas/1.json
  def show
    @eqa = Eqa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eqa }
    end
  end

  # GET /eqas/new
  # GET /eqas/new.json
  def new
    @eqa = Eqa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eqa }
    end
  end

  # GET /eqas/1/edit
  def edit
    @eqa = Eqa.find(params[:id])
  end

  # POST /eqas
  # POST /eqas.json
  def create
    @eqa = Eqa.new(params[:eqa])

    respond_to do |format|
      if @eqa.save
        format.html { redirect_to @eqa, notice: 'Eqa was successfully created.' }
        format.json { render json: @eqa, status: :created, location: @eqa }
      else
        format.html { render action: "new" }
        format.json { render json: @eqa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eqas/1
  # PUT /eqas/1.json
  def update
    @eqa = Eqa.find(params[:id])

    respond_to do |format|
      if @eqa.update_attributes(params[:eqa])
        format.html { redirect_to @eqa, notice: 'Eqa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eqa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eqas/1
  # DELETE /eqas/1.json
  def destroy
    @eqa = Eqa.find(params[:id])
    @eqa.destroy

    respond_to do |format|
      format.html { redirect_to eqas_url }
      format.json { head :no_content }
    end
  end
end
