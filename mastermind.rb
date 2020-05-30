COLORS = ['red', 'green', 'blue', 'yellow', 'black', 'white']

class Round
  attr_accessor :guesses
  
  def initialize
    @guesses = 1
  end

  def check_guess(input, code)

    guess = input.split(' ').map { |i| COLORS.index(i)}

    if guess.length != 4 || guess.include?(nil)
      puts "Invalid input"
      return
    end

    puts guess
    @guesses += 1
  end

end

class Player
  attr_accessor :code, :codemaker

  def initialize(codemaker)
    @codemaker = codemaker
    @code = []
  end

  def make_code
    4.times { code.push(rand(0..5))}
    puts code
  end
end

class Computer
  attr_accessor :code, :codemaker

  def initialize(codemaker)
    @codemaker = codemaker
    @code = []
  end

  def make_code
    4.times { code.push(rand(0..5))}
    puts code.map { |i| COLORS[i]}
  end
end


loop do

round = Round.new
player = Player.new(false)
computer = Computer.new(true)

player.codemaker ? player.make_code : computer.make_code

  loop do
    puts "Guess #{round.guesses}: "

    if player.codemaker
      round.check_guess(gets.chomp, player.code)
      puts "TODO"
    else
      round.check_guess(gets.chomp, computer.code)
    end
  end

end

