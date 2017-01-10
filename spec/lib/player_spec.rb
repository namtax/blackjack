require 'spec_helper'

describe Dealer do
  let(:player)        { Player.new }
  let!(:first_card)   { Card.new(14, 'hearts') }
  let!(:second_card)  { Card.new(6,  'hearts') }

  describe '#set_hand' do 
    it 'adds cards to players hand' do 
      player.set_hand([first_card, second_card])
      expect(player.hand).to eq([first_card, second_card])
    end
  end

  describe '#hit' do 
    let!(:first_card)  { Card.new(10, 'hearts') }
    let!(:second_card) { Card.new(2, 'hearts') }
    let!(:third_card)  { Card.new(4, 'hearts') }
    
    context 'inital hand has been set' do 
      before do 
        player.set_hand([first_card, second_card])
        expect(Card).to receive(:new).and_return(third_card)
      end

      it 'adds another card to players hand' do 
        player.hit
        expect(player.hand).to eq([first_card, second_card, third_card])
      end
    end

    context 'hand has not been set' do 
      it 'instructs user to set hand' do 
        expect(player.hit).to eq('Please set hand')
      end
    end
  end
end
