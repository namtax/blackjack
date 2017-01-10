class Dealer 
  attr_reader :card, :dealers_hand, :initial_hand, :suit, :hand, :players_hand

  MAX_SUM = 21

  def deal_hand(first_card = Card.new, second_card = Card.new)
    set_initial_hand(first_card, second_card)
   
    if total >= 20
      while total >= 20
        set_initial_hand(Card.new, Card.new)
      end
    end
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

  def set_initial_hand(first_card, second_card)
    @initial_hand  = [first_card, second_card]
    @dealers_hand  = [first_card, second_card]
    @players_hand  = [first_card, second_card]
  end

  def total
    initial_hand.map(&:number).inject(:+)
  end

  def hit_player
    return 'Please deal initial hand' unless players_hand

    players_hand << Card.new

    if players_total > MAX_SUM
      'Dealer Wins!'
    end 
  end

  def hit_dealer
    if dealers_total < 17
      while dealers_total < 17
        dealers_hand << Card.new
      end
    else
      dealers_hand << Card.new
    end

    if dealers_total > MAX_SUM
      'Player Wins!'
    end 
  end
end
