class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :name, :user_id, presence: true

  def self.choose_active
    where('active = ?', true)
  end
  
  def self.make_others_inactive(deck_id)
    where('id != ?', deck_id).update_all("active = 'false'")
  end
end
