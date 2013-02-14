class Formconfigchange < ActiveRecord::Migration
  def up
    change_table :form_configs do |t|
      t.references :form_builders
    end
    remove_column :form_configs, :return_forms_id
  end

  def down
  end
end
