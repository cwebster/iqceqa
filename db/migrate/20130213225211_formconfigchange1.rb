class Formconfigchange1 < ActiveRecord::Migration
  def up
    change_table :form_configs do |t|
      t.references :form_builder
    end
    remove_column :form_configs, :form_builders_id
  end

  def down
  end
end
