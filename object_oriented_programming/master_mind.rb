#create a trminal-based Mastermind game.
class Mastermind
    COLORS = ["r", "g", "b", "y", "w"]
    ROW = "( ) ( ) ( ) ( )"

    def initialize
        @board = []
        @winning_combination = ""
    end

    def start_game
        while true
            puts "Enter 1 to be the code breaker."
            puts "Enter 2 to be the code maker."
            input = gets.chomp[0]
            if input == "1"
                player_is_breaker
                break
            elsif input == "2"
                computer_is_breaker
                break
            else
                next
            end
        end
    end

    def player_is_breaker
        @codemaker = ComputerPlayer.new
        @codebreaker = Player.new
        @winning_combination = @codemaker.make_code
        puts "Valid colors are 'r', 'w', 'g', 'b' and 'y'."
        puts ROW
        10.times do |i|
            print "Enter your code (e.g 'rybg' - your code has to have unique colors): "
            guessed_code = gets.chomp.downcase[0..3]
            feedback = @codebreaker.check_attempt(guessed_code, @winning_combination)
            update_board(guessed_code, feedback)
            puts @board
            if game_over?(guessed_code, feedback)
                puts "Code breaker won!"
                break
            elsif i == 9
                puts "Code maker won! The secret code was #{@secret_code}"
            end
        end
    end

    def computer_is_breaker
        @codemaker = Player.new
        @codebreaker = ComputerPlayer.new
        @winning_combination = @codemaker.make_code
        code_guess = ""
        feedback = []
        wrong_guesses = []
        10.times do |i|
            wrong_guesses << code_guess
            code_guess = @codebreaker.generate_attempt(code_guess, feedback, wrong_guesses)
            feedback = @codemaker.check_attempt(code_guess, @winning_combination)
            update_board(code_guess, feedback)
            puts @board
            if game_over?(code_guess, feedback)
                puts "Computer guessed the code correctly!"
                break
            elsif i == 9
                puts "You won! The computer failed to guess the code."
            end
        end
        puts @board
    end 

    def update_board(guessed_code, feedback)
        attempt = guessed_code.split("")
        @board << "(#{attempt[0]}) (#{attempt[1]}) (#{attempt[2]}) (#{attempt[3]}) #{feedback.inspect}" 
    end

    def game_over?(guessed_code, feedback)
        feedback = feedback.join("")
        if feedback == "rrrr"
            true
        elsif guessed_code == "exit"
            true
        else
            false
        end
    end

    class ComputerPlayer
        def make_code
            code = ""	
            4.times do |i|
                while code.length != i + 1
                    color = COLORS[rand(5)]
                    code += color if !(code.include?(color))
                end
            end
            code
        end 
        
        def generate_attempt(prev_guess = "", feedback = [], wrong_guesses = [])
            code = ""
            valid = false
            feedback = feedback.join("")
            if feedback.length != 4
                4.times do |i|
                    while code.length != i + 1
                      color = COLORS[rand(5)]
                      code += color if !(code.include?(color))
                  end
                end
                code
            elsif feedback.length == 4
                while valid == false
                    code = ""
                    4.times do |i|
                        while code.length != i + 1
                        color = prev_guess.split("")[rand(4)]
                        code += color if !(code.include?(color))
                    end
                  end
                  valid = true unless wrong_guesses.any? {|wrong_code| code == wrong_code}
                end
                code
            end
        end

        def check_attempt(attempt, secret_code)
            feedback = []
            attempt = attempt.split("")
            attempt.each_with_index do |color, index|
                if color == secret_code[index]
                    feedback << "r"
                elsif secret_code.include?(color)
                    feedback << "w"
                end
            end
            feedback.shuffle
        end
    end

    class Player < ComputerPlayer
        def make_code
            puts "Valid colors are 'r', 'w', 'g', 'b' and 'y'."
            print "Enter the secret code (e.g. 'rgby') you'd like the computer to guess: "
            secret_code = gets.chomp.downcase[0..3]
            while (/[^rgbyw]/).match(secret_code) || secret_code.length != 4
                print "Enter the secret code (e.g. 'rgby') you'd like the computer to guess: "
                secret_code = gets.chomp.downcase[0..3] 
            end
            secret_code
        end
    end
end

new_game = Mastermind.new
new_game.start_game
