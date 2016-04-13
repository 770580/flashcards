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

  def inc_review_date(check_result)
    inc_time = [0, 12.hours, 3.days, 7.days, 2.weeks, 1.month]
    if check_result
      self.level += 1 if self.level < 5
    else
      self.error_count += 1
      if self.error_count == 3
        self.level = 1
        self.error_count = 0
      end
    end
    update(review_date: Time.now + inc_time[self.level], level: self.level, error_count: self.error_count)
  end
end
