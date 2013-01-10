class EqaResultReferenceAnalyser6 < ActiveRecord::Migration
  def up
  	change_table :eqas do |t|
  				t.references :analyser
  			end
			add_index :eqas, :analyser_id
  end

  def down
  end
end
