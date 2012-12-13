class CreateIqcs < ActiveRecord::Migration
  def change
    create_table :iqcs do |t|
      t.integer :IQCID
      t.string :name
      t.string :manufacturer
      t.string :notes
      t.boolean :assigned
      t.datetime :dateTimeCreated

      t.timestamps
    end
  end
end
