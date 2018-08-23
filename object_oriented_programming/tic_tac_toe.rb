#create a terminal-based Tic Tac Toe game.
class TicTacToe
    attr_reader :board, :curr_player

    WINS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    def initialize
        @player_1 = Player.new
        @player_2 = Player.new
        @board = Gameboard.new
        @curr_player = @player_1
    end

    def start_game
        puts "Welcome to TicTacToe"
        board.draw_board
        while true
            puts "#{curr_player.player_id}'s turn!"
            puts "Enter slot number, with 0 being the top left corner and 8 bottom right"
            puts "Enter exit to leave the game"
            input = gets.chomp
            input = input_validation(input) 
            break if input == "exit"
            place_token(input) 
            board.draw_board
            look_for_winner
            board_full?
            next_turn
        end
    end

    private

    def board_full?
        if !board.slots.any? {|slot| slot == "empty slot"}
            puts "It's a Draw"
            board.reset_board
        end
    end

    def look_for_winner
        winner = WINS.any? do |line|
            line.all? do |index|
            if board.slots[index].class == Token 
                board.slots[index].token_owner == curr_player.player_id
            end
          end
        end
        if winner
            print_winner(curr_player.player_id)
        end
    end

    def print_winner(winner)
        puts "#{winner} won!"
        board.reset_board
        puts "New game"
    end
    
    def next_turn
        @curr_player == @player_1 ? @curr_player = @player_2 : @curr_player = @player_1
    end
    
    def place_token(location)
        board.slots[location] = Token.new(curr_player.player_id)
    end
      
    def input_validation(input)
        return "exit" if input.downcase == "exit"
        input = input.to_i
        while true
            while !(input.between?(0,8))
                puts "Please, enter a number between 0 and 8"
                input = gets.chomp.to_i
            end
            if board.slots[input].class == Token
                puts "Slot not empty, please enter a different one"
                input = gets.chomp.to_i
                next 
            end
            return input
        end
    end

    class Player
        attr_accessor :player_id
    
            @@player_count = 0
            
            def initialize
                @@player_count += 1
                @player_id = "player_#{@@player_count}"
            end    
    end

    class Gameboard
        attr_accessor :slots
          
        def initialize
            @slots = (0..8).to_a
            @slots.map! { |slot| slot = "empty slot" }
          end
        
        def draw_board
            slots.each_with_index do |slot, index|
                if index == 2 || index == 5 || index == 8   
                    if slot.class == Token
                        puts "| #{slot.token_model} |"
                    else
                        puts "|   |"
                    end
                else
                    if slot.class == Token
                    print "| #{slot.token_model} |"
                    else
                    print "|   |"
                    end
                end
            end
        end

        def reset_board
            @slots.map! { |slot| slot = "empty slot" }
        end 
    end

    class Token
        attr_reader :token_model, :token_owner

        def initialize(player_id)
            @token_owner = player_id
            @token_owner == "player_1" ? @token_model = "X" : @token_model = "O"
        end 
    end
end


my_game = TicTacToe.new
my_game.start_game
