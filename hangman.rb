require 'yaml'
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
    @curr_string = ("_"*(@selected_word.length-2))
    @game_status = true
    @misses = []
    puts "\n Number of letters in the word: #{@selected_word.length-2} letters"
    puts @curr_string

    self.user_input()
  end

  def user_output
    puts "Till now #{@curr_string} and chances left #{@chances}"
  end

  def user_input
    puts "Guess a letter or enter 5 to save"
    user_input = gets.chomp
    user_input = user_input.downcase
    if user_input.length>1
      puts "Not valid input! try again \n"
      self.user_input
    elsif user_input =="5"
      self.save_progress
    else
      self.check_character(user_input)
    end
  end

  def check_character(c)
    if !@selected_word.include?(c)
       @misses.append(c)
       @chances-=1
    else
      for i in 0..@selected_word.length - 3
        if @selected_word[i]==c
          @curr_string[i] = c
        end
      end
    end

    self.check_game
  end

  def check_game
    if @selected_word==@curr_string and @chances>=0
      puts "Congrats you win!"
    elsif @chances <=0
      puts "You lose"
    else
      self.user_output
      self.user_input
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
