class CreateChangeLoggings < ActiveRecord::Migration
  def change
    create_table :change_loggings do |t|
      t.datetime :dateTimeLogged
      t.string :logRecord

      t.timestamps
    end
  end
end
