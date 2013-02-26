class AddPaperClipUploadToAnalyserTypes < ActiveRecord::Migration
  def change
    add_attachment :analyser_types, :analyser_picture
  end
end
