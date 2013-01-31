class AddReadCodetoTestCode < ActiveRecord::Migration
  def up
    add_column :test_codes,:readcode, :string
  end

  def down
  end
end
