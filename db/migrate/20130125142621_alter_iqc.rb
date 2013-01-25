class AlterIqc < ActiveRecord::Migration
  def up
     add_column :iqcs,:code, :string
     add_column :iqcs,:lotno, :string
     add_column :iqcs,:expirydate, :date
     add_column :iqcs,:storagelocation, :string
     add_column :iqcs,:storagetemp, :string
     add_column :iqcs,:dateinuse, :date
     add_column :iqcs,:datereconstituted, :date
     add_column :iqcs,:numberofaliquots, :integar
  end

  def down
  end
end
