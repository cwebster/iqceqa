class AddExcludeColumnIqcsData < ActiveRecord::Migration
  def up
  	add_column :imported_qcs, :transferred, :integer

  end

  def down
  end
end
