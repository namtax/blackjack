class Game 
  attr_reader :response

  MAX_FIRST_HAND = 20

  def initialize(dealer = Dealer.new, player = Player.new)
    @dealer   = dealer
    @player   = player
    @response = []
  end

  def start
    dealer.set_hand
    response << "Dealer: #{dealer.initial_numbers}"

    if dealer.total >= MAX_FIRST_HAND
      while dealer.total >= MAX_FIRST_HAND
        dealer.set_hand
        response << "Dealer: #{dealer.initial_numbers}"
      end
    end

    player.set_hand(dealer.hand)
  end

  def player_requests(request)
    return 'Please Start Game' unless dealer.hand
    response.clear

    if request == 'hit'
      hit_player
    elsif request == 'stand'  
      hit_dealer
    end
  end

  def over?
    player.lost? || dealer.lost?
  end

  private 
  attr_reader :dealer, :player

  def hit_player
    player.hit

    response << 'Player: hit'
    response << "Dealer: #{player.last_hand}"

    if player.lost?
      confirm_winner('Dealer')
    end
  end

  def hit_dealer
    dealer.hit
    
    response << 'Player: stand'
    response << "Dealer: #{dealer.last_hand}"

    if dealer.lost?
      confirm_winner('Player')
    end
  end

  def confirm_winner(card_player)
    response << "#{card_player} Wins!"
    response << "Player hand: #{player.final_score}"
    response << "Dealer hand: #{dealer.final_score}"
  end
end 
