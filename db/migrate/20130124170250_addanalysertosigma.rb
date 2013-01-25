class Addanalysertosigma < ActiveRecord::Migration
  def up
      add_column :sigmas,:analyser, :string
  end

  def down
  end
end
