class Game
  attr_accessor :scores

  def initialize
    @scores = [0, 0]
  end

  def start
    border = ["  :::::::::::::::::::"]
    puts [border, "  : TIC - TAC - TOE :", border, "\n", "-h for help", "\n"]
  end

  def help
    border = "." * 16
    instructions = ["  Instructions", " _ _ _    _ _ _", "|_|_|_|  |7|8|9|","|_|_|_|=>|4|5|6|","|_|_|_|  |1|2|3|"]
    commands = ["\n","-h for help", "-n to start a new game", "-e to exit program"]
    puts [border, border, instructions, commands, border, border]
  end

end

#

class Round
  attr_accessor :squares, :turn_a, :winner

  def initialize
    @squares = [['_','_','_'],['_','_','_'],['_','_','_']]
    @turn_a = true
    @winner = nil
  end

  def display(game)
    scores = "Player A #{game.scores[0]} - #{game.scores[1]} Player B"

    #Calculates padding to center the grid to the score
    pad = " " * (scores.index('-') - 3)

    #Creates borders to separate frames
    border = "." * scores.length

    #Takes @squares' values and formats them into rows
    rows = squares.map { |r| "#{pad}|#{r.join('|')}|"}
    rows.unshift("#{pad} _ _ _\n")

    puts [border, scores, rows, "\n"]
  end

  def turn(n)
    char = @turn_a ? "x" : "o"
    n -= 1
    if @squares[2 - (n/3).floor][n%3] == "_"

      @squares[2 - (n/3).floor][n%3] = char
      @turn_a = !@turn_a
    else
      puts "\n\nThat square is already filled!"
    end
  end

  def end?
    #Creates a string for each row
    rows = @squares.map { |r| r.join('')}

    #Creates a string for each column
    columns = []
    0.upto(2) do |i|
      c = ""
      0.upto(2) { |j| c += @squares[j][i]}
      columns.push(c)
    end
    
    #Creates a string for each diagonal
    diagonals = ["",""]
    0.upto(2) do |i|
      diagonals[0] += @squares[i][i]
      diagonals[1] += @squares[2-i][i]
    end

    lines = (rows << columns << diagonals).flatten
    #Loop over every direction, updates winner if found and returns true
    lines.each do |l|
      case l
      when "xxx"
        puts "\n\nPlayer A wins!"
        @winner = 0
        return true
      when "ooo"
        puts "\n\nPlayer B wins!"
        @winner = 1
        return true
      end
    end

    #Checks for a full board
    unless @squares.flatten.join('').include? "_"
      return true
    else
      return false
    end
  end
end




game = Game.new
round = Round.new

game.start
round.display(game)


loop do
  
  input = gets.chomp
  
  case input
  when /^[1-9]$/
    round.turn(input.to_i)

    if round.end?
      game.scores[round.winner] += 1 if round.winner != nil
      round.display(game)
      print "Press enter to continue "
      gets
      round = Round.new
      round.display(game)
    else
      round.display(game)
    end
  when 'h'
    game.help
    print "Press enter to continue "
    gets
    round.display(game)
  when 'n'
    game = Game.new
    round = Round.new
    round.display(game)
  when 'e'
    break
  else
    puts "h for help"
  end

end