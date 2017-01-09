require 'spec_helper'

describe Dealer do
  let(:dealer) { Dealer.new }
  let(:cards)  { dealer.cards }

  describe '#deal_hand' do 
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

  describe 'handle_request' do 
    before { dealer.deal_hand }

    context 'hit' do 
      it 'adds another card to players hand' do 
        dealer.handle_request('hit')
        expect(dealer.players_hand.size).to eq(3)
        expect(dealer.players_hand).to all( be_an(Card) )
      end

      it 'does not add another card to dealers hand' do 
        dealer.handle_request('hit')
        expect(dealer.dealers_hand.size).to eq(2)
      end
    end
  end
end
