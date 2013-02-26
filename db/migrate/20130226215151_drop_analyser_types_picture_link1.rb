class DropAnalyserTypesPictureLink1 < ActiveRecord::Migration
  def up
    remove_column :analyser_types, :analyser_types_picture_link
  end

  def down
  end
end
