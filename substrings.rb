dictionary = ["below","down","go","going","horn","how",
             "howdy","it","i","low","own","part","partner","sit"]
single = "below"

sentence = "Howdy partner, sit down! How's it going?"

def substrings(str, arr)
    str = str.downcase
    hash = {}
    for w in arr
        if str.include? w
            hash[w] = str.scan("#{w}").length
        end
    end
    hash
end

my_hash = substrings(sentence, dictionary)

print "#{my_hash}\n"