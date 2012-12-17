class AlterQualitySpecificationsDropTestCode < ActiveRecord::Migration
  def up
  	change_table :quality_specifications do |t|
  		t.remove :testCode
  	end
  end

  def down
  	change_table :quality_specifications do |t|
  		t.add_column :testCode
  	end
  end
end
