class TestCodesController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /test_codes
  # GET /test_codes.json
  def index
    @test_codes = TestCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_codes }
      format.csv { send_data TestCode.to_csv }
      format.xls # { send_data @TestCode.to_csv(col_sep: "\t")}
    end
  end

  # GET /test_codes/1
  # GET /test_codes/1.json
  def show
    @test_code = TestCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_code }
    end
  end

  # GET /test_codes/new
  # GET /test_codes/new.json
  def new
    @test_code = TestCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_code }
    end
  end

  def generate
    @gentest = TestCode.generate_test_codes_from_ams_data
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_code }
    end
    
  end


  # GET /test_codes/1/edit
  def edit
    @test_code = TestCode.find(params[:id])
  end

  # POST /test_codes
  # POST /test_codes.json
  def create
    @test_code = TestCode.new(params[:test_code])

    respond_to do |format|
      if @test_code.save
        
        @test_code.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'Test Code Created', :users_id => current_user.id)
        changeLogging.save
        
        format.html { redirect_to @test_code, notice: 'Test code was successfully created.' }
        format.json { render json: @test_code, status: :created, location: @test_code }
      else
        format.html { render action: "new" }
        format.json { render json: @test_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_codes/1
  # PUT /test_codes/1.json
  def update
    @test_code = TestCode.find(params[:id])

    respond_to do |format|
      if @test_code.update_attributes(params[:test_code])
        changeLogging = ChangeLogging.new(:logRecord => 'Test code updated: '+ params[:test_code].to_s, :users_id => current_user.id)
        changeLogging.save
        format.html { redirect_to @test_code, notice: 'Test code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_codes/1
  # DELETE /test_codes/1.json
  def destroy
    @test_code = TestCode.find(params[:id])
    @test_code.destroy

    respond_to do |format|
      format.html { redirect_to test_codes_url }
      format.json { head :no_content }
    end
  end
end
