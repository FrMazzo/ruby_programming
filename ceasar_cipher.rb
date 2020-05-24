def ceasar_cypher (string, shift)
    #Splits string into an array of characters
    chars = string.split('')
    #Aplies shift to each character
    chars.map! do |c|
        #Checks if c is a letter, if it's not it returns c
        if c.match(/[a-z]/i)
            upcase = false
            #Stores if c is upcase
            upcase = true if c == c.upcase
            #Lowercases c
            c = c.downcase
            #Turns c into an integer, substracts 97 to normalize (int for a = 0) and adds shift
            c = c.ord.to_i
            c = c - 97 + shift
            #Cycles negative values and positive values, adds 97
            c = 
                if c < 0
                    (26 - c) + 97
                else
                    (c % 26 ) + 97
                end
            #Turns c into a char again
            c = c.chr
            #Checks if it was upcase
            c = c.upcase if upcase
            c
        else 
            c
        end
    end
    chars.join('')
end

print "Enter text to cypher: \n"
string = gets.chomp
#Initializes shift variable
shift = ""
#Until shift only contains numbers
until shift.match(/^\-?[0-9]+$/)
    print "Enter letter shift: (integer)\n"
    shift = gets.chomp
end
#Turns shift to integer
shift = shift.to_i
#Symplifies shift value
shift = shift % 26
puts ceasar_cypher(string, shift)


