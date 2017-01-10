require 'card_player'

class Dealer 
  include CardPlayer
  attr_reader :card, :suit, :hand

  MAX_FIRST_HAND = 20

  def initialize(first_card = Card.new, second_card = Card.new)
    @first_card  = first_card
    @second_card = second_card
    set_initial_hand(@first_card, @second_card)
  end

  def set_hand
    if total >= MAX_FIRST_HAND
      while total >= MAX_FIRST_HAND
        set_initial_hand(Card.new, Card.new)
      end
    end
  end

  def hit
    return 'Please deal hand' unless hand

    hand << Card.new

    while total < 17
      hand << Card.new
    end
  end

  def total
    hand.map(&:number).inject(:+)
  end
  
  private

  def set_initial_hand(first_card, second_card)
    @hand  = [first_card, second_card]
  end
end
