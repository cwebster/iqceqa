class Create < ActiveRecord::Migration
  def up
    create_table :form_configs do |t|
      t.integer :order
      t.timestamps
      t.references :return_forms, :test_codes
    end
  end

  def down
  end
end
