class Card
  SUITS    = %w|hearts clubs diamonds spades|
  NUMBERS  = (2..14).to_a

  attr_reader :number, :suit

  def initialize(*args)
    @number  = args.first || fetch_number
    @suit    = args.last  || fetch_suit
  end

  def fetch_number 
    NUMBERS.sample
  end 

  def fetch_suit
    SUITS.sample
  end
end
  
