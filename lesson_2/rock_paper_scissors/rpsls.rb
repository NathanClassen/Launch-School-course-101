VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

SCORE_COMBINATIONS = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(scissors rock)
}.freeze

def prompt(message)
  puts "=> #{message}"
end

def win?(player1_input, player2_input)
  SCORE_COMBINATIONS[player1_input].include?(player2_input)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("**You won!**\n \n ")
  elsif win?(computer, player)
    prompt("**Computer won!**\n \n ")
  else
    prompt("**It was a tie!**\n \n ")
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

    computers_choice = VALID_CHOICES.sample

    prompt("You chose #{choice}; Computer chose #{computers_choice}..\n ")

    display_results(choice, computers_choice)

    if win?(choice, computers_choice)
      player_score += 1
    elsif win?(computers_choice, choice)
      computer_score += 1
    end

    if player_score >= 5 || computer_score >= 5
      announce_winner(player_score, computer_score)
      break
    end
  end

  prompt('Do you want to play again? y / n')
  play_again = ''

  loop do
    play_again = gets.chomp.downcase
    play_again.start_with?('y', 'n') ? break : prompt('Enter yes or no')
  end

  break unless play_again.start_with?('y')
end

prompt('Thanks for playing RockPaperScissorsLizardSpock!')
prompt('Bye-bye.')
