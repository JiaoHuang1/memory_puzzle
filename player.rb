class Player
    def get_move
        puts "Please enter a position to reveal a grid: "
        pos = gets.chomp
        row = pos[0].to_i
        col = pos[2].to_i
        until pos.length == 3 && (0..3).include?(row) && (0..3).include?(col) && pos[1] == " " do
            puts "Invalid entry! Please enter a position such as '0 3'"
            pos = gets.chomp
            row = pos[0].to_i
            col = pos[2].to_i
        end
        [row, col]
    end
end