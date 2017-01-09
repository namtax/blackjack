require 'spec_helper'

describe Dealer do
  let(:dealer) { Dealer.new }

  describe '#deal_hand' do 
    let(:cards) { dealer.deal_hand }

    it 'returns two cards' do 
      expect(cards.size).to eq(2)
      expect(cards).to all( be_an(Card) )
    end
  end
end
