class EqaResultReferenceAnalyser1 < ActiveRecord::Migration
  def up
  	add_column :eqas, :analyser_id, :integer
  	
  	change_table :eqas do |t|
  				t.references :analysers_id
  	end
			add_index :eqas, :analyser_id
  end

  def down
  end
end
