require 'spec_helper'

describe Dealer do
  let(:dealer) { Dealer.new }
  let(:cards)  { dealer.cards }

  describe '#deal_hand' do 
    context 'when sum of 2 cards value > 20' do 
      before { dealer.deal_hand }

      it 'adds two cards to dealers hand' do 
        expect(dealer.dealers_hand.size).to eq(2)
        expect(dealer.dealers_hand).to all( be_an(Card) )
      end

      it 'adds two cards to players hand' do 
        expect(dealer.dealers_hand.size).to eq(2)
        expect(dealer.dealers_hand).to all( be_an(Card) )
      end
    end

    context 'when sum of 2 cards value >=20' do 
      let!(:first_card)          { Card.new(14, 'hearts') }
      let!(:second_card)         { Card.new(6,  'hearts') }
      let!(:first_redealt_card)  { Card.new(15, 'hearts') }
      let!(:second_redealt_card) { Card.new(5,  'hearts') }
      let!(:third_redealt_card)  { Card.new(11, 'hearts') }
      let!(:fourth_redealt_card) { Card.new(8,  'hearts') }

      before do 
        expect(Card).to receive(:new)
          .and_return(first_redealt_card, second_redealt_card, third_redealt_card, fourth_redealt_card)
        dealer.deal_hand(first_card, second_card) 
      end

      it 'redeals the cards until cards value > 20' do 
        expect(dealer.dealers_hand).to match_array([third_redealt_card, fourth_redealt_card])
      end
    end
  end

  describe 'handle_request' do 
    before { dealer.deal_hand }

    context 'player calls hit' do 
      it 'adds another card to players hand' do 
        dealer.handle_request('hit')
        expect(dealer.players_hand.size).to eq(3)
        expect(dealer.players_hand).to all( be_an(Card) )
      end

      it 'does not add another card to dealers hand' do 
        dealer.handle_request('hit')
        expect(dealer.dealers_hand.size).to eq(2)
      end

      context 'player goes > 21' do 
        let(:first_card)  { Card.new(14, 'hearts') }
        let(:second_card) { Card.new(6, 'hearts') }
        let(:outcome)     { dealer.handle_request('stand') }

        before do 
          dealer.deal_hand(first_card, second_card) 
        end

        it 'marks dealer as winner' do 
          outcome = dealer.handle_request('hit')
          expect(outcome).to eq('Dealer Wins!')
        end
      end
    end

    context 'player calls stand' do 
      context 'dealers hand is >= 17 after first hit' do 
        let(:first_card)  { Card.new(10, 'hearts') }
        let(:second_card) { Card.new(2, 'hearts') }
        let(:third_card)  { Card.new(4, 'hearts') }

        before do 
          dealer.deal_hand(first_card, second_card )
          expect(Card).to receive(:new).at_least(:once).and_return(third_card)
        end

        it 'adds another card to dealers hand' do 
          dealer.handle_request('stand')
          expect(dealer.dealers_hand.size).to eq(4)
          expect(dealer.dealers_total >= 17).to be_truthy
        end
      end

      context 'dealers hand is > 17 after first hit' do 
        let(:first_card)  { Card.new(10, 'hearts') }
        let(:second_card) { Card.new(2, 'hearts') }
        let(:third_card)  { Card.new(6, 'hearts') }

        before do 
          dealer.deal_hand(first_card, second_card )
          expect(Card).to receive(:new).at_least(:once).and_return(third_card)
        end

        it 'does not add another card to dealers hand ' do 
          dealer.handle_request('stand')
          expect(dealer.dealers_hand.size).to eq(3)
          expect(dealer.dealers_total >= 17).to be_truthy
        end
      end

      context 'dealers hand is > 21' do 
        let(:first_card)  { Card.new(10, 'hearts') }
        let(:second_card) { Card.new(10, 'hearts') }

        before do 
          dealer.deal_hand(first_card, second_card )
        end

        it 'marks player as winner' do 
          outcome = dealer.handle_request('stand')
          expect(outcome).to eq('Player Wins!')
        end
      end
    end
  end
end
