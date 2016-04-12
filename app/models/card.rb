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

  def inc_review_date(box)
    case box
    when 1 then
      update(review_date: Time.now + 12.hours)
    when 2 then
      update(review_date: Time.now + 3.days)
    when 3 then
      update(review_date: Time.now + 7.days)
    when 4 then
      update(review_date: Time.now + 2.weeks)
    when 5 then
      update(review_date: Time.now + 1.month)
    end
  end
end
