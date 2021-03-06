class User < ActiveRecord::Base
  has_many :cards
  has_many :decks
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def has_linked_facebook?
    authentications.where(provider: 'facebook').present?
  end

  def self.pending_card_notify
    all.each do |user|
      card_count = Card.pending_cards_count(user)
      NotificationsMailer.pending_cards(user, card_count).deliver_now if card_count > 0
    end
  end
end
