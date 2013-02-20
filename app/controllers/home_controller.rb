class HomeController < ApplicationController
  def index
    
    @test_codes = TestCode.all
    
    @sigmas_optimal = Sigma.average(:sigmaScoreOptimal, :group => "strftime('%W%Y', dateOfEQA)", :order => ('dateOfEQA ASC'))

      @sigmas_desirable = Sigma.average(:sigmaScoreDesirable, :group => "strftime('%W%Y', dateOfEQA)", :order => ('dateOfEQA ASC'))

       @sigmas_minimum = Sigma.average(:sigmaScoreMinimum, :group => "strftime('%W%Y', dateOfEQA)", :order => ('dateOfEQA ASC'))

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
    
    option = { width: 640, height: 360, title: 'Average Sigma Performance per day',    colors:['#1c9bc8','#71dbff','#ffcf3d','#fd6770','#8c8c8c','#00A5C6','#DEBDDE','#000000'],
      :focusTarget => 'category',
      :series => [{areaOpacity: 0.9},{areaOpacity: 0.9},{areaOpacity: 0.5},{areaOpacity: 0.6}] }
    @chart = GoogleVisualr::Interactive::SteppedAreaChart.new(data_table, option)
    
    
  end
end
