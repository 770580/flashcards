class ChangeColumnNameBoxInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :box, :level
  end
end
