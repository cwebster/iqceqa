class AlterTestEqAaddSchemeLink < ActiveRecord::Migration
  def up
  	
  	remove_column :eqas, :scheme
  	
  	change_table :eqas do |t|
  				t.references :eqa_scheme
  	end
  	
  	add_index :eqas, :id
  end

  def down
  end
end
