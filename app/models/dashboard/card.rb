class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  mount_uploader :card_image, CardImageUploader
  validates :original_text, :translated_text, :review_date, :user_id, :deck_id, presence: true
  validate  :original_text_not_equal_translated_text

  def original_text_not_equal_translated_text
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:translated_text, "Перевод не должен быть таким же, как и оригинальное слово")
    end
  end

  def self.random
    where("review_date <= ?", Time.now).order("RANDOM()").first
  end

  def check_and_inc_review_date(input_text, answer_timer)
    memo = SuperMemo.new(self, input_text, answer_timer)
    update(review_date: Time.now + memo.interval.days, repetition: memo.repetition, e_factor: memo.e_factor, interval: memo.interval)
    { correct: memo.misprint < 4 ? true : false, misprints_count: memo.misprint }
  end

  def self.pending_cards_count(user)
    where(user_id: user.id).where("review_date <= ?", Time.now).count
  end
end
