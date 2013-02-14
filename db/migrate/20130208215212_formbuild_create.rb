class Create < ActiveRecord::Migration
  def up
      create_table :return_forms do |t|
        t.string :form_name
        t.string :description
        t.timestamps
        t.references :eqa_schemes
      end

  end

  def down
  end
end
