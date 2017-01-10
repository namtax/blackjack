class Player 
  include CardPlayer
  attr_reader :hand

  MAX_SUM = 21

  def set_hand(hand)
    @hand = hand.dup
  end

  def hit
    return 'Please set hand' unless hand
    hand << Card.new
  end
end
