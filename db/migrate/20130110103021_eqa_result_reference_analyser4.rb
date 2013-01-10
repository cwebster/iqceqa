class EqaResultReferenceAnalyser4 < ActiveRecord::Migration
  def up
  	remove_column :eqas, :analysers_id
  end

  def down
  end
end
