require 'YAML'
puts "Welcome to Hangman!"
puts "Select an option"
puts "1) Load a saved game"
puts "2) New Game"
puts "3) Exit"

class Game
  def initialize
    words = []
    contents = File.readlines "5desk.txt"
    contents.each do |word|
      if word.length > 5 and word.length<12
        words.append(word)
      end
    end
    @selected_word = ((words[rand*words.length]).downcase)
    @chances = 8
    @curr_string = ("_"*@selected_word.length)
    @game_status = true
    @misses = []
    puts "\n Number of letters in the word: #{@selected_word.length} letters"
    puts @curr_string
  end

  def user_output
    puts "Till now #{@curr_string} and chances left #{@chances}"
  end

  def user_input
    user_input = gets.chomp
    user_input = user_input.downcase
    if user_input.length>1
      puts "Not valid input! try again"
    end
  end

  def check_character(c)
    if !@selected_word.include?(c)
       @misses.append(c)
       @chances-=1
    else
      @selected_word.each do|ch|
        #something
      end
    end
  end

  def save_progress
    save_file = File.open("save.yaml","w")
    save_file.write(YAML.dump(self))
    save_file.close
  end

  def continue
    if File.exists?("save.yaml") && load_game?
      File.open("save.yaml","r") do |f|
        @hangman = YAML.load(f.read)
        @hangman.play
      end
    else
      @hangman = Hangman.new
    end
  end



end

option = gets.chomp
if option=="1"
  #Code for saved game
elsif option=="2"
  game = Game.new
elsif option=="3"
  #code_for_exit
else
  puts"Please enter a valid input!"
end
