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

  def check(input_text, answer_timer)
    quality = answer_quality(input_text, answer_timer)
    inc_review_date(quality)
    case @misprint
    when 0 then "right"
    when 1, 2, 3 then "misprint"
    end
  end

  def answer_quality(input_text, answer_timer)
    @misprint = DamerauLevenshtein.distance(original_text.mb_chars.downcase, input_text.mb_chars.downcase)
    case @misprint
    when 0 then
      if answer_timer.to_i < 10
        5
      elsif answer_timer.to_i <= 15
        4
      else
        3
      end
    when 1 then 3
    when 2 then 2
    when 3 then 1
    else 0
    end
  end

  def inc_review_date(quality)
    memo = SuperMemo.new(self, quality)
    update(review_date: Time.now + memo.interval.days, repetition: memo.repetition, e_factor: memo.e_factor, interval: memo.interval)
  end

  def self.pending_cards_count(user)
    where(user_id: user.id).where("review_date <= ?", Time.now).count
  end
end
