require 'spec_helper'

describe Card do
  let(:card)  { Card.new }
  let(:suits) { %w[hearts spades clubs diamonds] } 

  describe 'number' do 
    it { expect(card.number > 1).to be_truthy }
    it { expect(card.number < 15).to be_truthy }
  end

  describe 'suit' do
    it { expect(suits).to include(card.suit) }
  end
end
