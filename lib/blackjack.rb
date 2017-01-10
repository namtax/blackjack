require './lib/card_player'
require './lib/game'
require './lib/card'
require './lib/player'
require './lib/dealer'

class Blackjack
  def run
    game = Game.new
    game.start

    puts game.response
     
    while game_on
      input  = gets.chomp
      game.player_requests(input)

      puts game.response

      if game.over?
        end_game
      end
    end
  end

  def game_on
    @end.nil?
  end

  def end_game
    @end = true
  end
end
