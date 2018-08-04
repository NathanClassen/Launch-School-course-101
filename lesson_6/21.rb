CARDS = ['2', '3', '4', '5', '6', '7', '8'] +
        ['9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['<3', '<>', '**', '->']

def prompt(mssg)
  puts "==> #{mssg}"
end

def show_players_hand(arr, player = '')
  arr.each do |card|
    sleep(1)
    puts "+---------+"
    puts "|#{card[0]}        |"
    puts "|         |"
    puts "|         |"
    puts "|    #{card[1]}   |"
    puts "|         |"
    puts "|         |"
    puts "|        #{card[0]}|"
    puts "+_________+"
  end
  prompt "^^#{player} hand^^"
end

def initialize_deck
  deck = []
  CARDS.each do |card|
    SUITS.each do |suit|
      deck << [card, suit]
    end
  end
  deck
end

def draw_from(card, deck)
  deck.delete_if do |cards|
    cards[0] == card[0] && cards[1] == card[1]
  end
end

def draw(deck)
  card = deck.sample
  draw_from(card, deck)
  card
end

def calculate(hand)
  score = 0
  hand.each do |card|
    if card[0].to_i.to_s == card[0]
      score += card[0].to_i
    elsif %w[J K Q].include?(card[0])
      score += 10
    else
      score += 11
    end
  end
  calculate_aces(score, hand)
end

def declare_winner(dealer, player)
  prompt "#{determine_winner(dealer, player)} won!"
  if determine_winner(dealer, player) == false
    prompt "It's a tie."
  end
end

def determine_winner(dealer_score, player_score)
  if dealer_score > player_score
    'The dealer'
  elsif dealer_score == player_score
    'Nobody'
  else
    'You'
  end
end

def calculate_aces(score, hand)
  calculate_aces = hand.select { |card| card[0] == 'A' }
  calculate_aces.size.times do
    score -= 11
  end
  calculate_aces.size.times do
    if (score + 11) <= 21
      score += 11
    else
      score += 1
    end
  end
  score
end

def pause_for_effect(mssg)
  prompt "#{mssg}"
  sleep(2)
end

def bust?(score)
  score > 21
end

def nobody_busted?(a, b)
  !bust?(a) && !bust?(b)
end

loop do
  player_score = 0
  dealer_score = 0
  loop do
    players_hand = []
    dealers_hand = []

    deck = initialize_deck

    2.times do
      players_hand << draw(deck)
      dealers_hand << draw(deck)
    end

    player_score = calculate(players_hand)
    dealer_score = calculate(dealers_hand)

    prompt player_score
    show_players_hand(players_hand, 'Your')
    puts '============================='
    show_players_hand([dealers_hand[0]], "Dealer's")

    loop do
      player_will = ''
      loop do
        prompt "hit or stay?"
        player_will = gets.chomp.downcase
        break if player_will == 'hit' || player_will == 'stay'
      end
      if player_will == 'hit'
        players_hand << draw(deck)
        player_score = calculate(players_hand)
        break if bust?(player_score)
        pause_for_effect('you are dealt a card...')
        prompt "Current score: #{player_score}"
        show_players_hand(players_hand, 'Your')
      else
        prompt "You scored: #{player_score}"
        break
      end
    end

    loop do
      break if bust?(player_score)
      if dealer_score < 17
        prompt "Dealer will hit.."
        dealers_hand << draw(deck)
        pause_for_effect('dealer is drawing a card...')
        show_players_hand(dealers_hand, 'Dealer\'s')
        dealer_score = calculate(dealers_hand)
        break if bust?(dealer_score)
      else
        pause_for_effect('dealer is thinking...')
        prompt "Dealer will stay."
        break
      end
    end

    if bust?(player_score) || bust?(dealer_score)
      if bust?(player_score)
        pause_for_effect('you are dealt a card...')
        show_players_hand(players_hand, 'Your')
        prompt "YOU BUSTED!"
      else
        pause_for_effect('dealer is drawing a card...')
        show_players_hand(dealers_hand, "Dealer's")
        prompt "THE DEALER BUSTED. YOU WIN!!"
      end
    end

    if nobody_busted?(player_score, dealer_score)
      declare_winner(dealer_score, player_score)
    end
    break
  end
  answer = ''
  prompt "Would you like to play again?? (y / n)"
  loop do
    answer = gets.chomp.downcase
    break if %w[y n].include?(answer)
    puts "Please enter y or n"
  end
  break if answer == 'n'
end
