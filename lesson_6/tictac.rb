INIT_MARKER = ' '
PLAYER_MARKER = 'X'
COMP_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(mssg)
  puts "==> #{mssg}"
end

class Array
  def joinor(del = ',', word = 'or')
    string = ''
    each_index do |i|
      if i < (length - 2)
        string << self[i].to_s + "#{del} "
      elsif i == (length - 2)
        string << self[i].to_s + " #{word} "
      else
        string << self[i].to_s
      end
    end
    string
  end
end

## BOARD METHODS ########################################################
# rubocop: disable Metrics/AbcSize
def displ_board(brd)
  puts "You're #{PLAYER_MARKER}'s. Computer is #{COMP_MARKER}'s"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def init_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INIT_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == ' ' }
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count('X') == 3
      return 'Player'
    elsif board.values_at(*line).count('O') == 3
      return 'Computer'
    end
  end
  nil
end

## TURN TAKING METHODS ######################################################
def place_piece!(board, player)
  if player == 'Player'
    player_marks!(board)
  elsif player == 'Computer'
    comp_marks!(board)
  end
end

def alternate_player(current_player)
  players = ['Player', 'Computer']
  current_player == players[0] ? (return players[1]) : (return players[0])
end

## PLAYER's TURN METHOD ##########################################################
def player_marks!(board)
  square = ''
  loop do
    prompt "Mark an empty square (#{empty_squares(board).joinor}):"
    square = gets.chomp.to_i
    break if empty_squares(board).include? square
  end
  board[square] = PLAYER_MARKER
end

## COMPUTER'S TURN METHODS######################################################
def comp_marks!(board)
  if strong_ai_move(board)
    mark = strong_ai_move(board)
    board[mark] = COMP_MARKER
  elsif danger(board)
    mark = danger(board)
    board[mark] = COMP_MARKER
  elsif weak_ai_move(board)
    mark = weak_ai_move(board)
    board[mark] = COMP_MARKER
  elsif empty_squares(board).include?(5)
    board[5] = COMP_MARKER
  else
    mark = empty_squares(board).sample
    board[mark] = COMP_MARKER
  end
end

def danger(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count('X') == 2
      line.each do |num|
        if board[num] == ' '
          return num
        end
      end
    end
  end
  false
end

def strong_ai_move(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count('O') == 2
      line.each do |num|
        if board[num] == ' '
          return num
        end
      end
    end
  end
  false
end

def weak_ai_move(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count('O') == 1
      potential_moves = []
      line.each do |num|
        if board[num] == ' '
          potential_moves << num
        end
      end
      return potential_moves.sample
    end
  end
  false
end

### GAME LOOP #######################################################
loop do
  player_score = 0
  comp_score   = 0
  winner = ''
  players = ['Player', 'Computer']
  loop do
    board = init_board
    displ_board(board)
    current_player = players[0]
    loop do
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      displ_board(board)
      break if board_full?(board) || someone_won?(board)
    end

    if someone_won?(board)
      if detect_winner(board) == 'Player'
        player_score += 1
      else
        comp_score += 1
      end
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

    if player_score >= 5 || comp_score >= 5
      player_score > comp_score ? winner = "Player" : winner = "Computer"
      break
    end
  end

  prompt "#{winner} won the match!!"
  answer = ''
  loop do
    prompt "Play again? (Enter Y or N)"
    answer = gets.chomp.upcase
    break if %w[Y N].include?(answer)
  end

  break if answer == 'N'
end

prompt "Thank's for playing the most exciting game on the planet! Goodbye!"
