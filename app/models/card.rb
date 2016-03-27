class Card < ActiveRecord::Base
	validates :original_text,
	          :translated_text,
	          :review_date, presence: true
	validate  :original_text_not_equal_translated_text

	def original_text_not_equal_translated_text
	  if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
	  	errors.add(:translated_text, "не должны быть равно оригинальному слову")
	  end
	end
end
