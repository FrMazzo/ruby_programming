a1 = [8,4,1,7,5,10,9,6,3]
a2 = [8,4,1,7,5,15,18,25,10,9,6,3]

def merge_sort(arr)
  return arr if arr.length == 1

  arr_a = merge_sort(arr.slice(0...(arr.size / 2)))
  arr_b = merge_sort(arr.slice((arr.size / 2)..))

  arr_c = []
  ia = 0
  ib = 0
  ic = 0

  while arr_a[ia] && arr_b[ib] do
    if arr_a[ia] < arr_b[ib]
      arr_c[ic] =  arr_a[ia]
      ia += 1
    else
      arr_c[ic] =  arr_b[ib]
      ib += 1
    end
    ic += 1
  end

  (arr_c << arr_a[ia..]).flatten! unless arr_b[ib]
  (arr_c << arr_b[ib..]).flatten! unless arr_a[ia]
  
  arr_c
end

p merge_sort(a2)


a3 = []

n = 500

n.times { |i| a3[i] = rand(n)}
puts "a3 built"

p merge_sort(a3)