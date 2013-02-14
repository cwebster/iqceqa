class Formbuilderchange < ActiveRecord::Migration
  def up
    change_table :form_builders do |t|
      t.references :eqa_scheme
    end
    remove_column :form_builders, :eqa_schemes_id
  end

  def down
  end
end
