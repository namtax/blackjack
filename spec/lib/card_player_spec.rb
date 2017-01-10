require 'spec_helper'

describe CardPlayer do
  subject           { klass.new }
  let(:klass)       { Class.new{ include CardPlayer } }
  let(:first_card)  { double(number: 4) }
  let(:second_card) { double(number: 4) }
  let(:hand)        { [first_card, second_card] }

  before do 
    expect(subject).to receive(:hand).at_least(:once).and_return(hand)
  end

  describe 'initial_numbers' do
    it { expect(subject.initial_numbers).to eq '4 4' }
  end

  describe 'card_numbers' do
    it { expect(subject.card_numbers).to eq '4 + 4' }
  end

  describe 'last_card' do
    it { expect(subject.last_card).to eq 4 }
  end

  describe 'last_hand' do
    let(:third_card)  { double(number: 11) }
    let(:fourth_card) { double(number: 12) }
    let(:hand)        { [first_card, second_card, third_card, fourth_card] }

    it { expect(subject.last_hand).to eq '11 12' }
  end

  describe 'final_score' do
    it { expect(subject.final_score).to eq '4 + 4 = 8' }
  end

  describe 'total' do
    it { expect(subject.total).to eq 8 }
  end

  describe 'lost?' do
    context 'total > 21 ' do
      let(:first_card)  { double(number: 11) }
      let(:second_card) { double(number: 11) }
    
      it { expect(subject).to be_lost }
    end

    context 'total < 21 ' do
      let(:first_card)  { double(number: 9) }
      let(:second_card) { double(number: 11) }
    
      it { expect(subject).to_not be_lost }
    end
  end
end
