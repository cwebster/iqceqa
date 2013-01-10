class AddDateofEqa < ActiveRecord::Migration
  def up
  	add_column :eqas, :dateOfEQA, :date
  end

  def down
  end
end
