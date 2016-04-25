class SuperMemo
  def initialize(card, input_text, answer_timer)
    @card = card
    @input_text = input_text
    @answer_timer = answer_timer
  end

  def interval
    return 1 if quality < 3
    case @card.repetition
    when 1 then 1
    when 2 then 6
    else (@card.interval * e_factor).round
    end
  end

  def repetition
    return 1 if quality < 3
    @card.repetition + 1
  end

  def e_factor
    new_efactor = @card.e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    [new_efactor, 1.3].max
  end

  def quality
    quality_map = [[5, 4, 3], 3, 2, 1]
    # if a misprint = 0, then the quality is calculated by time spent (time_factor)
    time_factor = @answer_timer.to_i < 10? 0 : @answer_timer.to_i <= 15? 1 : 2
    # quality =
    misprint == 0? quality_map[misprint][time_factor] : misprint > 3? 0 : quality_map[misprint]
  end

  def misprint
    DamerauLevenshtein.distance(@card.original_text.mb_chars.downcase, @input_text.mb_chars.downcase)
  end
end
