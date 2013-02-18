class Formbuilderchange4 < ActiveRecord::Migration
  def up
    remove_column :form_configs, :eqa_scheme_id
    rename_column :form_configs, :order, :form_order
  end

  def down
  end
end
