class AddAnalyserClass < ActiveRecord::Migration
  def up
    change_table :analyser_types do |t|
  				t.references :analyser_classes
  	end
  end

  def down
  end
end
