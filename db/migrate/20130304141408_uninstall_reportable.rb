class UninstallReportable < ActiveRecord::Migration
  def up
    drop_table :reportable_cache
  end

  def down
  end
end
