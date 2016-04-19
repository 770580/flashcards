class ChangeColumnsNameInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :level, :repetition
    rename_column :cards, :error_count, :e_factor
    change_column :cards, :e_factor, :float, default: 2.5
  end
end
