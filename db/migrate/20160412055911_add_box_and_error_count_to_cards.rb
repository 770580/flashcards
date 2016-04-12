class AddBoxAndErrorCountToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box, :integer
    add_column :cards, :error_count, :integer
  end
end
