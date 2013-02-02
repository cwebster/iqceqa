class HomeController < ApplicationController
  def index
    
    @test_codes = TestCode.all
    
    @sigmas = Sigma.select("date(dateOfQC) as dateOfQC, avg(sigmaScoreOptimal) as sigmaScoreOptimal, avg(sigmaScoreDesirable) as sigmaScoreDesirable, avg(sigmaScoreMinimum) as sigmaScoreMinimum").group("date(dateOfQC)")
    
   @sigmas_optimal = Sigma.avg_sigma_optimal_week_report.to_a
   @sigmas_desirable = Sigma.avg_sigma_desirable_week_report.to_a
   @sigmas_minimum = Sigma.avg_sigma_minimum_week_report.to_a
    
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
    
    option = { width: 640, height: 360, title: 'Average Sigma Performance per day' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
    
    
  end
end
