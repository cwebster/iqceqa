class DropTestDateEqa < ActiveRecord::Migration
  def up
  	remove_column :eqas, :testCode
  	remove_column :eqas, :dateTimeCreated
  end

  def down
  end
end
