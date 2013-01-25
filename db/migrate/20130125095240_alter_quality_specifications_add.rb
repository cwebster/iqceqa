class AlterQualitySpecificationsAdd < ActiveRecord::Migration
  def up
    add_column :quality_specifications,:allowableCVoptimal, :double
    add_column :quality_specifications,:allowableCVdesirable, :double
    add_column :quality_specifications,:allowableCVminimum, :double
    add_column :quality_specifications,:allowableBIASoptimal, :double
    add_column :quality_specifications,:allowableBIASdesirable, :double
    add_column :quality_specifications,:allowableBIASminimum, :double
    add_column :quality_specifications,:minimumTE, :double
    add_column :quality_specifications,:desirableTE, :double
    add_column :quality_specifications,:optimalTE, :double
  end

  def down
  end
end
