require 'spec_helper'

describe Card do
  let(:suits) { %w[hearts spades clubs diamonds] } 

  describe '#number' do 
    it { expect(subject.number > 1).to be_truthy }
    it { expect(subject.number < 15).to be_truthy }
  end

  describe '#suit' do
    it { expect(suits).to include(subject.suit) }
  end

  describe '.initialize' do 
    subject { Card.new(10, 'hearts') }

    it { expect(subject.number).to eq(10) }
    it { expect(subject.suit).to eq('hearts') }
  end
end
