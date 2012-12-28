class AlterIqcDatumAddAnalyserIndex < ActiveRecord::Migration
  def up
  	add_index :analysers, :id
  end

  def down
  end
end
