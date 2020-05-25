my_arr = [3,8,5,7,2,4,1]

def bubble_sort(arr)
    tmp = nil
    x = 1
    (arr.length).times do
        (arr.length - x).times do |n|
            if arr[n] > arr[n+1]
                tmp = arr[n]
                arr[n] = arr[n+1]
                arr[n+1] = tmp
            end
        end
    x += 1
    end
end

print "#{my_arr} \n"

bubble_sort(my_arr)

print "#{my_arr} \n"
