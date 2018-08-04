require 'pry'

VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'paper' || second == 'spock')) ||
    (first == 'spock' && (second == 'scissors' || second == 'rock'))
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won.')
  else
    prompt('It was a tie!')
  end
end

def announce_winner(player1, player2)
  if player1 > player2
    prompt('You are the CHAMPION!')
  else
    prompt('The computer is the CHAMPION!')
  end
end

loop do
  player_score = 0
  computer_score = 0
  loop do
    choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp.downcase

      VALID_CHOICES.include?(choice) ? break : prompt('Invalid choice.')
    end

    comp_choice = VALID_CHOICES.sample
    puts ''

    prompt("You chose #{choice}; Computer chose #{comp_choice}..")

    puts ''
    puts ''

    display_results(choice, comp_choice)

    if win?(choice, comp_choice)
      player_score += 1
    elsif win?(comp_choice, choice)
      computer_score += 1
    end
    binding.pry
    if (player_score >= 5 || computer_score >= 5)
      announce_winner(player_score, computer_score)
      break
    end
  end

  prompt('Do you want to play again?')
  play_again = gets.chomp.downcase

  break unless play_again.start_with?('y')
end

prompt('Thanks for playing RockPaperScissorsLizardSpock!')
prompt('Bye-bye.')
