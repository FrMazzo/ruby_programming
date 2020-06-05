require 'JSON'

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
    puts "TODO save"
  end

  def load
    puts "TODO load"
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
  when /^[a-zA-Z]$/ then game.guess(input)
  when /^save$/ then game.save
  when /^load$/ then game.load
  when /^help$/ then game.help
  when /^exit$/ then break

  else puts "invalid input"
  end

end