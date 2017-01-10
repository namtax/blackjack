module CardPlayer
  def initial_numbers
    numbers.join(" ")
  end

  def card_numbers
    numbers.join(" + ")
  end

  def last_card
    hand.last.number    
  end

  def last_hand
    hand[2..-1].map(&:number).join(" ")   
  end

  def final_score
    "#{card_numbers} = #{total}"
  end
  
  def total
    numbers.inject(:+)
  end
  
  def lost?
    total > 21 
  end

  def numbers
    hand.map(&:number)
  end
end 
