class Dealer 
  include CardPlayer
  attr_reader :card, :hand

  def set_hand
    @hand = [Card.new, Card.new]
  end

  def hit
    return 'Please deal hand' unless hand
    hand << Card.new

    while total < 17
      hand << Card.new
    end
  end
end
