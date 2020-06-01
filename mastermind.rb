COLORS = ['red', 'green', 'blue', 'yellow', 'black', 'white']

class Round
  attr_accessor :guesses, :end
  
  def initialize
    @guesses = 1
    @code = []
    @end = false
    @code_colors = Hash.new(0)
  end

  def check_guess(input)

    guess = input.is_a?(String) ? input.split(' ').map { |i| COLORS.index(i)} : input

    if guess.length != @code.length || guess.include?(nil)
      puts "Invalid input"
      return
    end

    correct_id = 0
    correct_color = 0

    @code.length.times do |i|
      correct_id += 1 if @code[i] == guess[i]
    end

    @code_colors.each { |k,v| correct_color += [guess.count(k) , v].min}

    correct_color -= correct_id
    
    puts "#{'0 ' * correct_id}#{'O ' * correct_color}#{'x '*(@code.length - correct_id - correct_color)}\n\n"

    if correct_id == @code.length
      puts "Codebreaker wins!"
      @end = true
    elsif guesses == 10
      puts "Codemaker wins!"
      @end = true
    end

    @guesses += 1
  end

  def code=(input)
    @code = input
    @code.each { |i| @code_colors[i] += 1}
  end

  def instructions
    puts "TODO"
  end
end

class Player
  attr_accessor :codemaker

  def initialize
    @codemaker = false
  end

  def make_code

    code = []

    while code.length != 4 || code.include?(nil)

      puts "Invalid input" if code != nil

      print "Write code: "

      code = gets.chomp.split(' ').map { |i| COLORS.index(i)}

    end

    code
  end
end

class Computer
  attr_accessor :codemaker

  def initialize
    @codemaker = false
  end

  def make_code
    code = []
    4.times { code.push(rand(0..5))}
    #puts code.map { |i| COLORS[i]}
    code
  end

  def guess
    #TODO, it has to store every guess done and use logic to proceed
    guess = []
    4.times { guess.push(rand(0..COLORS.length))}
    puts guess.map { |i| COLORS[i]}.join(' ')
    guess
  end
end


loop do

  round = Round.new
  player = Player.new
  computer = Computer.new

  puts ["Enter cm to play as codemaker or cb to play as codebraker", "Enter h for help", "Enter e to exit"]
  
  input = gets.chomp

  case input
  when "cm"
    player.codemaker = true
  when "cb"
    computer.codemaker = true
  when "h"
    round.instructions
  when "e"
    break
  else
    next
  end

  round.code = player.codemaker ? player.make_code : computer.make_code

  puts ["\n","Round start","\n"]

    loop do
      puts "Guess #{round.guesses}: "

      input = gets.chomp

      case input
      when "h"
        round.instructions
      when "n"
        break
      end

      player.codemaker ? round.check_guess(computer.guess) : round.check_guess(input)

      break if round.end

    end
end

