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
        
        changeLogging = ChangeLogging.new(:logRecord => 'Sigma updated: ' + params[:id] , :users_id => current_user.id)
        changeLogging.save
        
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
      changeLogging = ChangeLogging.new(:logRecord => 'Sigma deleted: ' + params[:id], :users_id => current_user.id)
      changeLogging.save
      
      format.html { redirect_to sigmas_url }
      format.json { head :no_content }
    end
  end
  
  def allTestsSigmaPlot
     Sigma.calculateSigmas
     @sigmas_optimal = Sigma.average(:sigmaScoreOptimal, :group => "YEARWEEK(dateOfEQA)", :order => ('dateOfEQA ASC'))

       @sigmas_desirable = Sigma.average(:sigmaScoreDesirable, :group => "YEARWEEK(dateOfEQA)", :order => ('dateOfEQA ASC'))

        @sigmas_minimum = Sigma.average(:sigmaScoreMinimum, :group => "YEARWEEK(dateOfEQA)", :order => ('dateOfEQA ASC'))

     data_table = GoogleVisualr::DataTable.new

     # Add Column Headers 
     data_table.new_column('string', 'Week Number & Year' ) 
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
      
      opts   = { :width => 600, :height => 300 }
      @chart = GoogleVisualr::Interactive::MotionChart.new(data_table, opts)
    
    
  end
  
  def plotSigmas
    
     Sigma.calculateSigmas
     
     
    @sigmas_optimal = Sigma.average(:sigmaScoreOptimal, :group => "YEARWEEK(dateOfEQA)", :conditions => ['test_code_id = ?', params[:test_code_id][:id]], :order => ('dateOfEQA ASC'))
    
     @sigmas_desirable = Sigma.average(:sigmaScoreDesirable, :group => "YEARWEEK(dateOfEQA)", :conditions => ['test_code_id = ?', params[:test_code_id][:id]], :order => ('dateOfEQA ASC'))
     
      @sigmas_minimum = Sigma.average(:sigmaScoreMinimum, :group => "YEARWEEK(dateOfEQA)", :conditions => ['test_code_id = ?', params[:test_code_id][:id]], :order => ('dateOfEQA ASC'))
  
    data_table = GoogleVisualr::DataTable.new
  
    # Add Column Headers 
    data_table.new_column('string', 'Week Number & Year' ) 
    data_table.new_column('number', 'Sigma Score Optimal') 
    data_table.new_column('number', 'Sigma Score Desirable') 
    data_table.new_column('number', 'Sigma Score Minimum') 
    data_table.new_column('number', 'Acceptable Sigma') 

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
    
    count=0
    @sigmas_minimum.each do |x,y|
      data_table.set_cell( count, 4, 3  )
      count+=1
    end
    
    
    opts   = { :width => 640, :height => 360, :title => 'Average Sigma Performance for '+TestCode.find(params[:test_code_id][:id]).testExpansion,
                 :hAxis => { :title => 'Week Number and Year' },
                 :vAxis => { :title => 'Sigma Score' },
                 :legend => {position: 'right', textStyle: {color: 'blue', fontSize: 10}}, 
                 :lineWidth => 1 , 
                 :pointSize => 1,
                 colors:['#1c9bc8','#71dbff','#ffcf3d','#fd6770','#8c8c8c','#00A5C6','#DEBDDE','#000000'],
                 :focusTarget => 'category',
                 :series => [{areaOpacity: 0.9},{areaOpacity: 0.9},{areaOpacity: 0.5},{areaOpacity: 0.6}]
                 }
    
    
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, opts)
  

    
  end
  
  
  
  
end
