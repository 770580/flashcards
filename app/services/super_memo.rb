class SuperMemo

  def initialize(card, quality)
    @card = card
    @quality = quality
  end

  def interval
  	return 1 if @quality < 3
    case @card.repetition
    when 1 then 1
    when 2 then 6
    else ((@card.interval) * self.e_factor).round
    end
  end

  def repetition
    return 1 if @quality < 3
    @card.repetition + 1 
  end

  def e_factor
  	new_efactor = @card.e_factor + (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
    [new_efactor, 1.3].max
  end
end
