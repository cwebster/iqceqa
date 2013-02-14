class EqaResultReferenceAnalyser6 < ActiveRecord::Migration
  def up
  	change_table :eqas do |t|
  				t.references :analyser
  			end
			add_index :eqa_schemes, :analyser_id
  end

  def down
  end
end
