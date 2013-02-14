class Formconfigchange2 < ActiveRecord::Migration
  def up
    change_table :form_configs do |t|
      t.references :eqa_scheme
    end
    remove_column :form_configs, :eqa_schemes_id
  end

  def down
  end
end
