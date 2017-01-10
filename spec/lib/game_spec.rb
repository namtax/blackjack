require 'spec_helper'

describe Game do 
  let(:first_card)  { double(number: 2) }
  let(:second_card) { double(number: 11) }
  let(:player)      { double(hand: nil, set_hand: nil) }
  subject           { described_class.new(dealer, player) }

  describe '#start!' do
    let(:dealer) { Dealer.new }

    context '2 cards value > 20' do 
      before do 
        expect(Card).to receive(:new).and_return(first_card, second_card)
      end
    
      it 'returns initial hand' do
        subject.start
        expect(subject.response).to eq(['Dealer: 2 11'])
      end
    end

    context ' 2 cards value >= 20' do
      let!(:first_card)  { Card.new(12, 'hearts') }
      let!(:second_card) { Card.new(10, 'hearts') }
      let!(:third_card)  { Card.new(8, 'hearts') }
      let!(:fourth_card) { Card.new(13, 'hearts') }
      let!(:fifth_card)  { Card.new(13, 'hearts') }
      let!(:sixth_card)  { Card.new(6, 'hearts') }

      before do 
        expect(Card).to receive(:new)
          .and_return(first_card, second_card, third_card, fourth_card, fifth_card, sixth_card) 
      end

      it 'redeals the cards until cards value > 20' do 
        subject.start
        expect(subject.response).to eq(['Dealer: 12 10', 'Dealer: 8 13', 'Dealer: 13 6'])
      end
    end
  end

  describe '#player_requests' do 
    let(:dealer)       { Dealer.new }
    let(:player)       { Player.new }
    let(:third_card)   { double(number: 4) }
    let(:fourth_card)  { double(number: 7) }
    let(:dealers_hand) { [first_card, second_card] }
    let(:players_hand) { [first_card, second_card, third_card] }

    context 'game started' do 
      before do 
        subject.start 
      end

      context 'hit' do 
        before do 
          allow(dealer).to receive(:hit)
          allow(dealer).to receive(:dealers_hand).and_return(dealers_hand)
          allow(player).to receive(:hit)
          allow(player).to receive(:hand).and_return(players_hand)
        end

        it 'notifies that player has hit' do 
          subject.player_requests('hit')
          expect(subject.response.first).to eq('Player: hit')
        end

        it 'returns players hit' do 
          subject.player_requests('hit')
          expect(subject.response.last).to eq('Dealer: 4')
        end

        context 'player total > 21' do 
          let(:end_message) do 
            [
              'Dealer Wins!', 
              'Player hand: 2 + 11 + 4 + 7 = 24', 
              'Dealer hand: 2 + 11 = 13'
            ]
          end 

          before do 
            expect(player).to receive(:total).at_least(:once).and_return(24)
            expect(player).to receive(:hit).and_return(24)
            expect(player).to receive(:hand).and_return(players_hand)
            allow(dealer).to receive(:hand).and_return(dealers_hand)
            players_hand << fourth_card
          end
          
          it 'notifies that dealer has won' do
            subject.player_requests('hit')
            expect(subject.response.last(3)).to eq(end_message)
          end 
        end
      end

      context 'stand' do 
        let(:fourth_card)  { double(number: 14) }
        let(:dealers_hand) { [first_card, second_card, third_card, fourth_card] }

        before do 
          allow(dealer).to receive(:hit)
          expect(dealer).to receive(:hand).at_least(:once).and_return(dealers_hand)
        end

        it 'notifies that player called stand' do 
          subject.player_requests('stand')
          expect(subject.response.first).to eq('Player: stand')
        end

        it 'returns dealers last hit' do 
          subject.player_requests('stand')
          expect(subject.response[1]).to eq('Dealer: 4 14')
        end

        context 'dealer total > 21' do 
          let(:players_hand) { [first_card, second_card] }
          let(:end_message) do 
            [
              'Player Wins!', 
              'Player hand: 2 + 11 = 13', 
              'Dealer hand: 2 + 11 + 4 + 14 = 24'
            ]
          end

          before do 
            expect(dealer).to receive(:total).at_least(:once).and_return(24)
            expect(player).to receive(:hand).at_least(:once).and_return(players_hand)
            allow(dealer).to receive(:hand).and_return(dealers_hand)
          end

          it 'notifies that dealer has won' do
            subject.player_requests('stand')
            expect(subject.response.last(3)).to eq(end_message)
          end 
        end
      end
    end

    context 'game not started' do 
      it 'returns error message' do 
        expect(subject.player_requests('hit')).to eq('Please Start Game')
      end
    end

    context 'invalid command' do 
      it 'notifies users' do 
        subject.start
        expect(subject.player_requests('false')).to eq(['Please select hit or stand'])
      end
    end

    describe '#over?' do 
      context 'player lost' do 
        before do 
          allow(player).to receive(:lost?).and_return(true)
        end

        it { expect(subject).to be_over }
      end

      context 'dealer lost' do 
        before do 
          allow(player).to receive(:lost?).and_return(false)
          allow(dealer).to receive(:lost?).and_return(true)
        end

        it { expect(subject).to be_over }
      end

      context 'game still in play' do 
        before do 
          allow(player).to receive(:lost?).and_return(false)
          allow(dealer).to receive(:lost?).and_return(false)
        end

        it { expect(subject).to_not be_over }
      end
    end
  end
end
