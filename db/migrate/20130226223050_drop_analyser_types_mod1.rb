class DropAnalyserTypesMod1 < ActiveRecord::Migration
  def up
    add_column :analyser_types, :analyser_type_class, :integer
  end

  def down
  end
end
