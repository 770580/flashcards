class ChangeDefaultValueRepetitionInCards < ActiveRecord::Migration
  def change
    change_column :cards, :repetition, :integer, default: 1
  end
end
