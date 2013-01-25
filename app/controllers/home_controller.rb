class HomeController < ApplicationController
  def index
    
    @test_codes = TestCode.all
    
    @sigmas = Sigma.select("date(dateOfQC) as dateOfQC, avg(sigmaScoreOptimal) as sigmaScoreOptimal, avg(sigmaScoreDesirable) as sigmaScoreDesirable, avg(sigmaScoreMinimum) as sigmaScoreMinimum").group("date(dateOfQC)")
    
    data_table = GoogleVisualr::DataTable.new
    
    # Add Column Headers 
    data_table.new_column('date', 'Date' ) 
    data_table.new_column('number', 'Sigma Score Optimal') 
    data_table.new_column('number', 'Sigma Score Desirable') 
    data_table.new_column('number', 'Sigma Score Minimum') 

    # Add Rows and Values 
    
    @sigmas.each do |sigma| 
    
      data_table.add_rows([ 
        [sigma.dateOfQC, sigma.sigmaScoreOptimal, sigma.sigmaScoreDesirable, sigma.sigmaScoreMinimum]
        ])
    end
    
    option = { width: 640, height: 360, title: 'Average Sigma Performance per day' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
    
    
  end
end
