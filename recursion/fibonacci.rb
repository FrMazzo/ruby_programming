def fibs(n)
  arr = []
  a = 0
  b = 1
  
  n.times do
    arr.push(a)
    c = a + b
    a = b
    b = c
  end

  arr
end

def fibs_rec(n)
  puts "fibs_rec called with #{n}"
  return [] if n == 0
  return [0] if n == 1
  return [0,1] if n == 2
  arr = fibs_rec(n-1)
  arr.push(arr[-1] + arr[-2])
  puts "fibs_rec(#{n}) => #{arr}"
  puts "     pushes #{arr[-1]}, adding #{arr[-2]} and #{arr[-3]}"
  return arr
end

p fibs_rec(7)