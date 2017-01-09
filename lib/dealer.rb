class Dealer 
  attr_reader :card, :dealers_hand, :suit, :hand, :players_hand

  def deal_hand(first_card = nil, second_card = nil)
    @first_card   = first_card  || Card.new
    @second_card  = second_card || Card.new
    @hand         = [@first_card, @second_card]
    @players_hand = @hand.dup
    @dealers_hand = @hand.dup
  end

  def handle_request(input)
    if input == 'hit'
      players_hand << Card.new
    end 
  end
end
