class DropAnalyserTypesPictureLink2 < ActiveRecord::Migration
  def up
    remove_column :analyser_types, :analyser_type_picture_link
  end

  def down
  end
end
