require 'pry'

stocks = [17,3,6,9,15,8,1,10]


def find_max_difference(array)
    #Indexes to return
    indexes = []
    #Current smallest value's index
    small_id = 0
    #Difference between smallest value and current index
    tmp_diff = 0
    #Max difference between smallest value and upto current index
    diff = 0
    #Current max diff
    max_diff = 0

    array.each_with_index do |n, i|
        small_id = i if array[i] < array[small_id]

        tmp_diff = array[i] - array[small_id] 

        diff = tmp_diff if tmp_diff > diff

        if diff > max_diff
            max_diff = diff 
            indexes[0] = small_id
            indexes[1] = i
        end
    end

    [indexes[0], indexes[1], max_diff]
end

def stock_format (array)
    "Buy on day: #{array[0]}\nSell on day: #{array[1]}\nProfit: #{array[2].round(2)}\n"
end

print "Insert stock prices: "
#Filters any non valid inputs
stocks = gets.scan(/\d+\.\d+|\d+/)
#Converts each number to float or integer
stocks.map! { |n| n.match(/\./) ? n.to_f : n.to_i}

print "Stock prices: #{stocks}\n"

print stock_format(find_max_difference(stocks))

# 17,3,6,9,15,8,6,1,10 => [1,4,12]
