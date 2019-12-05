### please enter "ruby board.rb" to play the game!

require_relative "Card"
require_relative "Player"

class Board
attr_reader :board, :temp_board
    def initialize
        @board = Array.new(4) {Array.new(4, " ")} 
        @cards = Array.new(4) {Array.new}
        @player = Player.new
    end

    def select_cards                                                            ### populate @cards array with 8 pairs of random card instance from ALPHA letters
        face_value_tracker = []                                                 ### generate 8 pairs of card instances and shuffle them to a random order
        cards = []
        while cards.length < 16
            card = Card.new
            if !face_value_tracker.include?(card.reveal)
                face_value_tracker << card.reveal
                2.times {|i| cards << card}
            end
        end
        cards.shuffle!

        (0...@cards.length).each do |i|                                         ### put the cards in @cards array
            cards.each_with_index do |card, idx|
                if idx % 4 == i
                    @cards[i] << card
                end
            end
        end    
    end

    def reveal                                                                  ### get a move from player and reveal the card value
        pos = @player.get_move
        row, col = pos
        until @board[row][col] == " " do
            puts "The position is taken!"
            pos = @player.get_move
            row, col = pos
        end
        letter = @cards[row][col].reveal
        @board[row][col] = letter
        pos
    end

    def match?                                                                  ### after two plays, compare the letters
        pos_1 = self.reveal
        self.print

        pos_2 = self.reveal
        self.print

        row_1, col_1 = pos_1
        letter_1 = @board[row_1][col_1]
        row_2, col_2 = pos_2
        letter_2 = @board[row_2][col_2]
        
        if letter_1 != letter_2                                                 ### if the letters doesn't match, return the @board with those two pos empty again
            puts "Not a match! Try again!"
            @board[row_1][col_1] = " "
            @board[row_2][col_2] = " "
        else
            puts "Found a match!"                                               ### if the letters match, letters stay on @board
        end
        self.print
    end

    def game_over?                                                              ### if all pos on @board are revealed, game over.
        @board.each do |row|
            row.each do |grid|
                return false if grid == " "
            end
        end
    end

    def print                                                                   ### print the @board with a header and left coordinates
        first_row = [" ", 0, 1, 2, 3]
        puts first_row.join(" ")
        @board.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end

    def run  
        self.select_cards
        self.print
        until game_over? do
            self.match?
        end
        puts "You win the game!"
    end
end

board = Board.new
board.run




