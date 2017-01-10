require 'spec_helper'

describe Dealer do
  let!(:first_card)   { Card.new(10, 'hearts') }
  let!(:second_card)  { Card.new(2,  'hearts') }
  let(:cards)         { [first_card, second_card] }
  
  before do 
    allow(Card).to receive(:new).and_return(*cards)
  end

  describe '#set_hand' do 
    it 'adds first cards to dealers hand' do 
      subject.set_hand
      expect(subject.hand).to eq(cards)
    end
  end

  describe '#hit' do 
    context 'dealers hand is >= 17 after first hit' do 
      let!(:third_card)  { Card.new(4, 'hearts') }
      let!(:fourth_card) { Card.new(10, 'hearts') }
      let(:cards)        { [first_card, second_card, third_card, fourth_card]}

      before { subject.set_hand }

      it 'adds another card to dealers hand' do 
        subject.hit
        expect(subject.hand).to eq(cards)
      end
    end

    context 'dealers hand is > 17 after first hit' do 
      let(:third_card)  { Card.new(6, 'hearts') }
      let(:cards)       { [first_card, second_card, third_card] }

      before { subject.set_hand }

      it 'does not add another card to dealers hand' do 
        subject.hit
        expect(subject.hand).to eq(cards)
        expect(subject.total >= 17).to be_truthy
      end
    end

    context 'dealers hand empty' do 
      it { expect(subject.hit).to eq('Please deal hand') }
    end
  end
end
