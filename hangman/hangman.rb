require 'json'

class Game
  attr_accessor :word, :misses, :guessed_chars

  def initialize(word, misses = 0, guessed_chars = [])
    @word = word.downcase
    @misses = misses 
    @guessed_chars = guessed_chars  
  end


  def draw_hangman

    hangman = ["      _____", "     |     |", "     |", "     |", "   __|__", " _|_____|_", "|____#{@misses}____|"]
  
    hangman[2] = "     |     o" if @misses > 0
    hangman[3] = "     |     |" if @misses > 1
    hangman[3] = "     |    /|" if @misses > 2
    hangman[3] = "     |    /|\\" if @misses > 3
    hangman[4] = "   __|__  /" if @misses > 4
    hangman[4] = "   __|__  / \\" if @misses > 5
  
    hangman
  end

  def guess(char)
    @word.include?(char) ? @guessed_chars.push(char) : @misses += 1
  end

  def display_word
    @word.split('')
         .map { |c| @guessed_chars.include?(c) ? c : '_'}
         .join(' ')
  end

  def save
    JSON.dump({
      :word => @word, 
      :misses => @misses,  
      :guessed_chars => @guessed_chars
    })
  end

  def load(string)
    data = JSON.load string
    @word = data['word']
    @misses = data['misses']
    @guessed_chars = data['guessed_chars']
  end

  def help
    puts "TODO help"
  end
  
end

game = Game.new("hello")

loop do
  puts game.draw_hangman
  puts

  puts game.display_word
  puts

  input = gets.chomp.downcase

  case input
  when /^[a-zA-Z]$/
    game.guess(input)
  when /^save$/
    save = File.open("save.txt",'w')
    save.puts game.save
    save.close

    puts "Game saved."
  when /^load$/
    save = File.open("save.txt", 'r')
    save_data = save.read
    game.load(save_data)

    puts "Game loaded."
  when /^help$/
    game.help
  when /^exit$/
    break
  else puts "invalid input"
  end

end