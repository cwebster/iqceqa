class EqaResultReferenceAnalyser5 < ActiveRecord::Migration
  def up
  	remove_column :eqas, :analyser_id
  end

  def down
  end
end
