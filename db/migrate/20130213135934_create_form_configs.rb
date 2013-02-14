class CreateFormConfigs < ActiveRecord::Migration
  def change
    create_table :form_configs do |t|
      t.integer :order
      t.references :return_forms, :test_codes
      t.timestamps
    end
  end
end
