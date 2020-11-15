require 'pry'

class TicTacToe
    
    attr_reader :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end
    
    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        #binding.pry
        @board[index] != " " 
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end
   
    def turn_count
        @board.count do |turn|
            turn == "X" || turn == "O"
        end
    end

    def current_player
        self.turn_count.odd? ? "O" : "X"
    end

    def turn
        puts "Please enter 1-9:"
        user_input = gets.strip
        index = input_to_index(user_input)
        if self.valid_move?(index)
            self.move(index, self.current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            win_combo.all? do |position|
                @board[position] == "X"
            end ||
            win_combo.all? do |position|
                @board[position] == "O"
            end
        end
    end

    def full?
        self.turn_count == 9
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.draw? || self.won?
    end
      
    def winner
        self.won? ? @board[self.won?[0]] : nil
    end
       
    def play 
        while !over?
          turn 
        end
        puts "Congratulations #{self.winner}!" if self.won?
        puts "Cat's Game!" if self.draw?
    end
end

