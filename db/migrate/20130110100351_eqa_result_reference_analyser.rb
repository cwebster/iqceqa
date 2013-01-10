class EqaResultReferenceAnalyser < ActiveRecord::Migration
  def up
  	 	
  	change_table :eqas do |t|
  		t.references :analysers
  	end
  	

  end

  def down
  end
end
