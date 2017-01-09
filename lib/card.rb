class Card
  SUITS    = %w|hearts clubs diamonds spades|
  NUMBERS  = (2..14).to_a

  def number 
    NUMBERS.sample
  end 

  def suit
    SUITS.sample
  end
end
  
