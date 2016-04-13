class ChangeBoxAndErrorCountInCards < ActiveRecord::Migration
  def change
    change_column :cards, :box, :integer, default: 0
    change_column :cards, :error_count, :integer, default: 0
  end
end
