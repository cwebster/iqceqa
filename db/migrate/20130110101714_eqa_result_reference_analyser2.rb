class EqaResultReferenceAnalyser2 < ActiveRecord::Migration
  def up
  
  	  		remove_column :eqas, :analyser_id, :analysers_id, :analyser_id_id

  			change_table :eqas do |t|
  				t.references :analyser
  			end
			add_index :eqas, :analyser_id
  end

  def down
  end
end
