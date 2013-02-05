class SigmasController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  # GET /sigmas
  # GET /sigmas.json
  def index
    # Update the sigma database if new IQC or EQA added
    Sigma.calculateSigmas
    @sigmas = Sigma.all
    @sigmas_by_date = @sigmas.group_by{ |item| item.dateOfQC.to_date }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    

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
  
  def allTestsSigmaPlot
    
    @sigmas = Sigma.select("testname, analyser, date(dateOfQC) as dateOfQC, avg(sigmaScoreOptimal) as sigmaScoreOptimal, avg(sigmaScoreDesirable) as sigmaScoreDesirable, avg(sigmaScoreMinimum) as sigmaScoreMinimum").group("date(dateOfQC)")
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Test Name'   )
      data_table.new_column('date'  , 'Date'    )
      data_table.new_column('number', 'Sigma Score Optimal'   )
      data_table.new_column('number', 'Sigma Score Desirable')
      data_table.new_column('number', 'Sigma Score Minimum')
      data_table.new_column('string', 'Analyser')
      
      @sigmas.each do |sigma| 

        data_table.add_rows([ 
          [sigma.testname, sigma.dateOfQC, sigma.sigmaScoreOptimal, sigma.sigmaScoreDesirable, sigma.sigmaScoreMinimum, sigma.analyser]
          ])
      end
      
      opts   = { :width => 600, :height => 300 }
      @chart = GoogleVisualr::Interactive::MotionChart.new(data_table, opts)
    
    
  end
  
  def plotSigmas
    
    @sigmas_optimal = Sigma.avg_sigma_optimal_week_report(:conditions => ["test_code_id = ?", params[:test_code_id][:id]]).to_a
    
     @sigmas_desirable = Sigma.avg_sigma_desirable_week_report(:conditions => ["test_code_id = ?", params[:test_code_id][:id]]).to_a
     
      @sigmas_minimum = Sigma.avg_sigma_minimum_week_report(:conditions => ["test_code_id = ?", params[:test_code_id][:id]]).to_a
  
    data_table = GoogleVisualr::DataTable.new
  
    # Add Column Headers 
    data_table.new_column('date', 'Date' ) 
    data_table.new_column('number', 'Sigma Score Optimal') 
    data_table.new_column('number', 'Sigma Score Desirable') 
    data_table.new_column('number', 'Sigma Score Minimum') 

    # Add Rows and Values 
    
    data_table.add_rows(@sigmas_minimum.size)
    
    count=0
    @sigmas_optimal.each do |x,y|
      data_table.set_cell( count, 0, x  )
      data_table.set_cell( count, 1, y  )
      count+=1
    end
    
    count=0
    @sigmas_desirable.each do |x,y|
      data_table.set_cell( count, 2, y  )
      count+=1
    end
    
    count=0
    @sigmas_minimum.each do |x,y|
      data_table.set_cell( count, 3, y  )
      count+=1
    end
    
    opts   = { :width => 640, :height => 360, :title => 'Avg Sigma Performance for ',
                 :hAxis => { :title => 'Date' },
                 :vAxis => { :title => 'Sigma Score' },
                 :legend => 'none' , 
                 :lineWidth => 2 , 
                 :pointSize => 1}
    
    
    @chart = GoogleVisualr::Interactive::ScatterChart.new(data_table, opts)
  

    
  end
  
  
  
  
end
