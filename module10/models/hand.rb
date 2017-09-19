
class Hand
  def total_score(cards)
    total_score = 0
    ace_count = 0
    
    cards.each do |card|
      ace_count += 1 if card.value == 'A'
      total_score += card.points
      total_score -= 10 if ace_count > 0 && total_score > 21
    end
    total_score
  end  
end