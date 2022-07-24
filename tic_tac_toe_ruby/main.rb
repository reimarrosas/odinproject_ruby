# frozen_string_literal: true

# Represents the Tic Tac Toe Game Board
class Board
  def initialize
    @size = 3
    @state = Array.new(@size) { Array.new(@size, nil) }
  end

  def place_char?(x_pos, y_pos, turn)
    @state[y_pos][x_pos] = turn
  end

  def valid_position?(x_pos, y_pos)
    @state[y_pos][x_pos].nil?
  end

  def paint_board
    @state.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        paint_row(col, col_idx)
      end
      paint_row_border(row_idx)
    end
    puts
  end

  def winner?(turn)
    line_checker(turn) || diagonal_checker(turn)
  end

  def full?
    @state.flatten.none?(nil)
  end

  private

  def paint_row(char, idx)
    to_print = char || '-'
    if idx < @size - 1
      print " #{to_print} |"
    else
      puts " #{to_print}"
    end
  end

  def paint_row_border(idx)
    puts '---+---+---' unless idx == @size - 1
  end

  def line_checker(turn)
    reduce_disjunct = ->(acc, cur) { acc || cur.all?(turn) }
    @state.reduce(false, &reduce_disjunct) ||
      @state.transpose.reduce(false, &reduce_disjunct)
  end

  def diagonal_checker(turn)
    indexer = (0..2)
    indexer.map { |i| @state[i][i] }.all?(turn) ||
      indexer.map { |i| @state[i][-i - 1] }.all?(turn)
  end
end

# Game representaiton of Tic Tac Toe
class Game
  def initialize(board)
    @turn = 'X'
    @board = board
    @running = true
  end

  def start
    welcome_prompt
    while @running
      raw_x, raw_y = prompt_user_input
      if /^[0-2]$/.match(raw_x) && /^[0-2]$/.match(raw_y) && @board.valid_position?(raw_x.to_i, raw_y.to_i)
        @board.place_char?(raw_x.to_i, raw_y.to_i, @turn)
        choose_repaint
      else
        puts "Invalid position input!\n"
      end
    end
  end

  private
  
  def welcome_prompt
    puts "Welcome to Ruby Tic Tac Toe!\n\n"
  end

  def prompt_user_input
    puts "Turn: #{@turn}"
    print 'Choose x: '
    raw_x = gets.chomp
    print 'Choose y: '
    raw_y = gets.chomp
    puts
    [raw_x, raw_y]
  end

  def change_turn
    @turn = @turn == 'X' ? 'O' : 'X'
  end

  def choose_repaint
    @board.paint_board
    if @board.winner?(@turn) || @board.full?
      puts game_end_prompt
      @running = false
    else
      change_turn
    end
  end

  def game_end_prompt
    if @board.full?
      'Board full! Draw!'
    else
      "Congratulations! #{@turn} is the winner!\n"
    end
  end
end

game = Game.new(Board.new)

game.start
