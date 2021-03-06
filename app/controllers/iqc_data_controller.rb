class IqcDataController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /iqc_data
  # GET /iqc_data.json
  def index
    @iqc_data = IqcDatum.all
    @qc_lots= IqcDatum.all(:group => :iqc_id)
    @analyser_results = IqcDatum.all(:group => :analyser_id)
    @test_results = IqcDatum.all(:group => :test_code_id)
    
    
    @iqc_by_date = @iqc_data.group_by{ |item| item.dateOfIQC.to_date }
    
    
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @iqc_data }
    end
  end
  
  def transfer
    @transferred = IqcDatum.transfer_ams_qc
  end


 
  def show_analyser_view
    @iqc_data = IqcDatum.where("analyser_id = ?", params[:analyser_id])
    @analyser = Analyser.find(params[:analyser_id])
    @analyser_type = AnalyserType.find(@analyser.analyser_types_id)
    @tests = IqcDatum.where("analyser_id = ?", params[:analyser_id]).group(:test_code_id)
  end
  
  def show_iqc_material_view
    @iqc_data = Iqc.where("id = ?", params[:iqc_id])
    @tests = IqcDatum.where("iqc_id = ?", params[:iqc_id]).group(:test_code_id)
    @analyser = IqcDatum.where("iqc_id = ?", params[:iqc_id]).group(:analyser_id)
    
  end
  
  def show_test_view
    @tests = TestCode.where("id = ?", params[:test_code_id])
    @analyser = IqcDatum.where("test_code_id = ?", params[:test_code_id]).group(:analyser_id)
    @iqc_data = IqcDatum.where("test_code_id = ?", params[:test_code_id]).group(:iqc_id)
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
 
  def test_view
    @iqc_data = IqcDatum.where("iqc_id = ? and test_code_id = ? and exclude_point =0", params[:iqc_id], params[:test_code_id]).order("dateOfIQC")
    @iqc_data_all = IqcDatum.where("iqc_id = ? and test_code_id = ?", params[:iqc_id], params[:test_code_id]).order("dateOfIQC")
    @quality_specification = QualitySpecification.where("test_code_id = ?", params[:test_code_id])
    
    unless @iqc_data.nil? || @iqc_data == []
      @testname = TestCode.find(params[:test_code_id])
      result = @iqc_data.map {|i| i.result.to_f }
      stats = DescriptiveStatistics::Stats.new(result)
      @mean = stats.mean
      @median = stats.median
      @range = stats.range
      @min = stats.min
      @max = stats.max
      @sd = stats.standard_deviation
      if @sd.nil?
        @sd = @mean
      else
        @cv = (@sd /@mean)*100
      end

      untrimmed_result = @iqc_data_all.map {|i| i.result.to_f }
      untrimmed_stats = DescriptiveStatistics::Stats.new(untrimmed_result)
      @untrimmed_mean = untrimmed_stats.mean
      @untrimmed_median = untrimmed_stats.median
      @untrimmed_range = untrimmed_stats.range
      @untrimmed_min = untrimmed_stats.min
      @untrimmed_max = untrimmed_stats.max
      @untrimmed_sd = untrimmed_stats.standard_deviation
      if @untrimmed_sd.nil?
        @untrimmed_sd = @mean
      else
        @untrimmed_cv = (@untrimmed_sd /@untrimmed_mean)*100
      end

      data_table = GoogleVisualr::DataTable.new
      untrimmed_results_table = GoogleVisualr::DataTable.new


     # Add Column Headers 
     data_table.new_column('datetime', 'Date and Time' ) 
     data_table.new_column('number', 'QC Result') 
     data_table.new_column('number', '-2 SD') 
     data_table.new_column('number', '+2 SD') 
     
     untrimmed_results_table.new_column('datetime', 'Date and Time' ) 
     untrimmed_results_table.new_column('number', 'QC Result')
	 untrimmed_results_table.new_column('number', '-2 SD') 
     untrimmed_results_table.new_column('number', '+2 SD') 

         # Add Rows and Values 

     data_table.add_rows(@iqc_data.size)
     untrimmed_results_table.add_rows(@iqc_data_all.size)

     count=0
     @iqc_data.each do |data_point|
       data_table.set_cell( count, 0, data_point.dateOfIQC )
       data_table.set_cell( count, 1, data_point.result.to_f  )
       data_table.set_cell( count, 2, (@mean-(@sd*2)).to_f)
       data_table.set_cell( count, 3, (@mean+(@sd*2)).to_f)
       count+=1
     end

	 count=0
    
	 @iqc_data_all.each do |data_point|
        untrimmed_results_table.set_cell( count, 0, data_point.dateOfIQC )
		untrimmed_results_table.set_cell( count, 1, data_point.result.to_f  )
		untrimmed_results_table.set_cell( count, 2, (@untrimmed_mean-(@untrimmed_sd*2)).to_f)
		untrimmed_results_table.set_cell( count, 3, (@untrimmed_mean+(@untrimmed_sd*2)).to_f)
		count+=1
	 end
     
    
	 opts   = { :width => 512, :height => 360, :title => 'IQC Over Time: Trimmed Results',
                  :hAxis => { :title => 'Date/Time' },
                  :vAxis => { :title => 'Result' , :minValue => (@mean - (@sd*4)), :maxValue => (@mean + (@sd*4)) },
                  :lineWidth => 1,
                  :series => {2 => {color: 'red', visibleInLegend: false, pointSize:0}, 1 =>{color: 'red', visibleInLegend: false, pointSize:0}},
                  :legend => 'none' }

     @chart = GoogleVisualr::Interactive::ScatterChart.new(data_table, opts)
     
     opts   = { :width => 512, :height => 360, :title => 'IQC Over Time: Untrimmed Results',
                  :hAxis => { :title => 'Date/Time' },
                  :vAxis => { :title => 'Result' , :minValue => (@mean - (@sd*4)), :maxValue => (@mean + (@sd*4)) },
                  :lineWidth => 1,
                  :series => {2 => {color: 'red', visibleInLegend: false, pointSize:0}, 1 =>{color: 'red', visibleInLegend: false, pointSize:0}},
                  :legend => 'none' }
     @chart2 = GoogleVisualr::Interactive::ScatterChart.new(untrimmed_results_table, opts)
    
    end #end of unless
  
  
  end

  def view_iqc_stats
    @iqc_data = IqcDatum.where("iqc_id = ? and test_code_id = ? and analyser_id = ? and exclude_point =0", params[:iqc_id], params[:test_code_id], params[:analyser_id]).order("dateOfIQC")
    @iqc_data_all = IqcDatum.where("iqc_id = ? and test_code_id = ? and analyser_id = ?", params[:iqc_id], params[:test_code_id], params[:analyser_id]).order("dateOfIQC")
    
    @quality_specification = QualitySpecification.where("test_code_id = ?", params[:test_code_id])
    
    unless @iqc_data.nil? || @iqc_data == []
      @testname = TestCode.find(params[:test_code_id])
      result = @iqc_data.map {|i| i.result.to_f }
      stats = DescriptiveStatistics::Stats.new(result)
      @mean = stats.mean
      @median = stats.median
      @range = stats.range
      @min = stats.min
      @max = stats.max
      @sd = stats.standard_deviation
      if @sd.nil?
        @sd = @mean
      else
        @cv = (@sd /@mean)*100
      end
      
      untrimmed_result = @iqc_data_all.map {|i| i.result.to_f }
      untrimmed_stats = DescriptiveStatistics::Stats.new(untrimmed_result)
      @untrimmed_mean = untrimmed_stats.mean
      @untrimmed_median = untrimmed_stats.median
      @untrimmed_range = untrimmed_stats.range
      @untrimmed_min = untrimmed_stats.min
      @untrimmed_max = untrimmed_stats.max
      @untrimmed_sd = untrimmed_stats.standard_deviation
      if @untrimmed_sd.nil?
        @untrimmed_sd = @mean
      else
        @untrimmed_cv = (@untrimmed_sd /@untrimmed_mean)*100
      end

     
      
      data_table = GoogleVisualr::DataTable.new
      untrimmed_results_table = GoogleVisualr::DataTable.new

     # Add Column Headers 
     data_table.new_column('datetime', 'Date and Time' ) 
     data_table.new_column('number', 'QC Result') 
     data_table.new_column('number', '-2 SD') 
     data_table.new_column('number', '+2 SD') 
     
     untrimmed_results_table.new_column('datetime', 'Date and Time' ) 
     untrimmed_results_table.new_column('number', 'QC Result')
	 untrimmed_results_table.new_column('number', '-2 SD') 
     untrimmed_results_table.new_column('number', '+2 SD') 

     # Add Rows and Values 

     data_table.add_rows(@iqc_data.size)
     untrimmed_results_table.add_rows(@iqc_data_all.size)

     count=0
     @iqc_data.each do |data_point|
       data_table.set_cell( count, 0, data_point.dateOfIQC )
       data_table.set_cell( count, 1, data_point.result.to_f  )
       data_table.set_cell( count, 2, (@mean-(@sd*2)).to_f)
       data_table.set_cell( count, 3, (@mean+(@sd*2)).to_f)
       count+=1
     end

	 count=0
    
	 @iqc_data_all.each do |data_point|
        untrimmed_results_table.set_cell( count, 0, data_point.dateOfIQC )
		untrimmed_results_table.set_cell( count, 1, data_point.result.to_f  )
		untrimmed_results_table.set_cell( count, 2, (@untrimmed_mean-(@untrimmed_sd*2)).to_f)
		untrimmed_results_table.set_cell( count, 3, (@untrimmed_mean+(@untrimmed_sd*2)).to_f)
		count+=1
	 end
    
     opts   = { :width => 512, :height => 360, :title => 'IQC Over Time: Trimmed Results',
                  :hAxis => { :title => 'Date/Time' },
                  :vAxis => { :title => 'Result' , :minValue => (@mean - (@sd*4)), :maxValue => (@mean + (@sd*4)) },
                  :lineWidth => 1,
                  :series => {2 => {color: 'red', visibleInLegend: false, pointSize:0}, 1 =>{color: 'red', visibleInLegend: false, pointSize:0}},
                  :legend => 'none' }

     @chart = GoogleVisualr::Interactive::ScatterChart.new(data_table, opts)
     
     opts   = { :width => 512, :height => 360, :title => 'IQC Over Time: Untrimmed Results',
                  :hAxis => { :title => 'Date/Time' },
                  :vAxis => { :title => 'Result' , :minValue => (@mean - (@sd*4)), :maxValue => (@mean + (@sd*4)) },
                  :lineWidth => 1,
                  :series => {2 => {color: 'red', visibleInLegend: false, pointSize:0}, 1 =>{color: 'red', visibleInLegend: false, pointSize:0}},
                  :legend => 'none' }
     @chart2 = GoogleVisualr::Interactive::ScatterChart.new(untrimmed_results_table, opts)
    
    end #end of unless
  
  end

  def view_analyser_stats
    @iqc_data = IqcDatum.where("test_code_id = ? and analyser_id = ?", params[:test_code_id], params[:analyser_id]).order("dateOfIQC")
    @quality_specification = QualitySpecification.where("test_code_id = ?", [:test_code_id])
    
    unless @iqc_data.nil? || @iqc_data == []
      @testname = TestCode.find(params[:test_code_id])
      result = @iqc_data.map {|i| i.result.to_f }
      stats = DescriptiveStatistics::Stats.new(result)
      @mean = stats.mean
      @median = stats.median
      @range = stats.range
      @min = stats.min
      @max = stats.max
      @sd = stats.standard_deviation
      if @sd.nil?
        @sd = @mean
      else
        @cv = (@sd /@mean)*100
      end
      data_table = GoogleVisualr::DataTable.new
      results_table = GoogleVisualr::DataTable.new

     # Add Column Headers 
     data_table.new_column('datetime', 'Date and Time' ) 
     data_table.new_column('number', 'QC Result') 
     data_table.new_column('number', '-2 SD') 
     data_table.new_column('number', '+2 SD') 
     
     results_table.new_column('datetime', 'Date and Time' ) 
     results_table.new_column('number', 'QC Result')

     # Add Rows and Values 

     data_table.add_rows(@iqc_data.size)
     results_table.add_rows(@iqc_data.size)

     count=0
     @iqc_data.each do |data_point|
       data_table.set_cell( count, 0, data_point.dateOfIQC )
       data_table.set_cell( count, 1, data_point.result.to_f  )
       data_table.set_cell( count, 2, (@mean-(@sd*2)).to_f)
       data_table.set_cell( count, 3, (@mean+(@sd*2)).to_f)
       
       results_table.set_cell( count, 0, data_point.dateOfIQC )
       results_table.set_cell( count, 1, data_point.result.to_f  )
       count+=1
     end

     
    
     opts   = { :width => 640, :height => 360, :title => 'IQC Over Time',
                  :hAxis => { :title => 'Date/Time' },
                  :vAxis => { :title => 'Result' , :minValue => (@mean - (@sd*4)), :maxValue => (@mean + (@sd*4)) },
                  :lineWidth => 1,
                  :series => {2 => {color: 'red', visibleInLegend: false, pointSize:0}, 1 =>{color: 'red', visibleInLegend: false, pointSize:0}},
                  :legend => 'none' }

     @chart = GoogleVisualr::Interactive::ScatterChart.new(data_table, opts)
    
      opts   = { :width => 600, :showRowNumber => true, :alternatingRowStyle => true }
      @chart2 = GoogleVisualr::Interactive::Table.new(results_table, opts)
    
    end #end of unless
  
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
        @iqc_datum.users_id = current_user.id
        changeLogging = ChangeLogging.new(:logRecord => 'QC Result Entered', :users_id => current_user.id)
        changeLogging.save
        
        Sigma.calculateSigmas
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
        
        # If weve updated an IQC we need to recalculate the Sigma
        @iqc_datum.usedInCalculation = 0
        Sigma.calculateSigmas
        
        changeLogging = ChangeLogging.new(:logRecord => 'QC result updated: ' + params[:iqc_datum].to_s, :users_id => current_user.id)
        changeLogging.save
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
    
    changeLogging = ChangeLogging.new(:logRecord => 'QC result deleted: ' +params[:id], :users_id => current_user.id)
    changeLogging.save

    respond_to do |format|
      format.html { redirect_to iqc_data_url }
      format.json { head :no_content }
    end
  end
end
