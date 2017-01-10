require 'spec_helper'

describe Dealer do
  let(:dealer)        { Dealer.new(first_card, second_card) }
  let!(:first_card)   { Card.new(14, 'hearts') }
  let!(:second_card)  { Card.new(6,  'hearts') }
  let(:cards)         { dealer.cards }

  describe '#initialize' do 
    context 'when sum of first 2 cards value > 20' do 
      it 'adds first cards to dealers hand' do 
        expect(dealer.hand).to eq([first_card, second_card])
      end
    end
  end

  describe '#set_hand' do 
    context 'when sum of first 2 cards value >=20' do 
      let!(:first_redealt_card)  { Card.new(15, 'hearts') }
      let!(:second_redealt_card) { Card.new(5,  'hearts') }
      let!(:third_redealt_card)  { Card.new(11, 'hearts') }
      let!(:fourth_redealt_card) { Card.new(8,  'hearts') }

      before do 
        expect(Card).to receive(:new)
          .and_return(first_redealt_card, second_redealt_card, third_redealt_card, fourth_redealt_card)
      end

      it 'redeals the cards until cards value > 20' do 
        dealer.set_hand
        expect(dealer.hand).to match_array([third_redealt_card, fourth_redealt_card])
      end
    end
  end

  describe '#hit' do 
    context 'dealers hand is >= 17 after first hit' do 
     let!(:first_card)  { Card.new(10, 'hearts') }
     let!(:second_card) { Card.new(2, 'hearts') }
     let!(:third_card)  { Card.new(4, 'hearts') }
     let!(:fourth_card) { Card.new(10, 'hearts') }

     before do 
       dealer.set_hand
       expect(Card).to receive(:new).and_return(third_card, fourth_card)
     end

     it 'adds another card to dealers hand' do 
       dealer.hit
       expect(dealer.hand).to eq([first_card, second_card, third_card, fourth_card])
     end
    end

    context 'dealers hand is > 17 after first hit' do 
     let(:first_card)  { Card.new(10, 'hearts') }
     let(:second_card) { Card.new(2, 'hearts') }
     let(:third_card)  { Card.new(6, 'hearts') }

      before do 
        dealer.set_hand
        expect(Card).to receive(:new).and_return(third_card)
      end

      it 'does not add another card to dealers hand' do 
        dealer.hit
        expect(dealer.hand.size).to eq(3)
        expect(dealer.total >= 17).to be_truthy
      end
    end

    context 'dealers hand is > 21' do 
     let!(:first_card)          { Card.new(8, 'hearts') }
     let!(:second_card)         { Card.new(10, 'hearts') }
     let!(:dealers_first_hit)   { Card.new(10, 'hearts') }

     before do 
       dealer.set_hand
       allow(Card).to receive(:new).and_return(dealers_first_hit)
     end

     it 'marks player as loser' do 
       outcome = dealer.hit
       expect(dealer).to be_lost
     end
    end
  end
end
