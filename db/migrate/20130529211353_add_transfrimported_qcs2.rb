class AddTransfrimportedQcs2 < ActiveRecord::Migration
  def up
        add_column :iqc_data, :exclude_result, :integer
  end

  def down
  end
end
