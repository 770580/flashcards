class AddCardImageToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_image, :string
  end
end
