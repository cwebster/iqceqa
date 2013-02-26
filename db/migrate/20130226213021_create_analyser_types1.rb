class CreateAnalyserTypes1 < ActiveRecord::Migration
  def up
    change_table :analysers do |t|
  				t.references :analyser_types
  			end

  end

  def down
  end
end
