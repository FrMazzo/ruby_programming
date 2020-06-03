def draw_hangman(n)

  hangman = ["      _____", "     |     |", "     |", "     |", "   __|__", " _|_____|_", "|____#{n}____|"]

  hangman[2] = "     |     o" if n > 0
  hangman[3] = "     |     |" if n > 1
  hangman[3] = "     |    /|" if n > 2
  hangman[3] = "     |    /|\\" if n > 3
  hangman[4] = "   __|__  /" if n > 4
  hangman[4] = "   __|__  / \\" if n > 5

  hangman
end

0.upto(6) { |i| puts draw_hangman(i)}




