class EqaResultReferenceAnalyser6 < ActiveRecord::Migration
  def up
  	change_table :eqas do |t|
  				t.references :analyser
  			end
  	
  end

  def down
  end
end
