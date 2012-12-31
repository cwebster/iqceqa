class AlterSigmaTable2 < ActiveRecord::Migration
  def up
  	remove_column :sigmas, :dateTimeCreated
  	remove_column :sigmas, :testCode
  end

  def down
  end
end
