class EqaResultReferenceAnalyser3 < ActiveRecord::Migration
  def up
  	remove_column :eqas, :analysers_id_id
  end

  def down
  end
end
