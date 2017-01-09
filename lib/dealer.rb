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
      hit_player
    elsif input == 'stand'
      hit_dealer
    end
  end

  def players_total
   players_hand.map(&:number).inject(:+)
  end

  def dealers_total
   dealers_hand.map(&:number).inject(:+)
  end

  private

  def hit_player
    players_hand << Card.new

    if players_total > 21 
      'Dealer Wins!'
    end 
  end

  def hit_dealer
    while dealers_total < 17
      dealers_hand << Card.new
    end
  end
end
