class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :name, :user_id, presence: true

  def self.chose_active

  end
  
  def self.make_active(deck_id)
    where('id != ?', deck_id).update_all("active = 'false'")
  end
end
