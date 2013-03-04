class AnalyserAlterations < ActiveRecord::Migration
  def up
    change_table :analysers do |t|
  				t.references :analyser_types
  			end
			add_index :analysers, :analyser_types_id
  end

  def down
  end
end
