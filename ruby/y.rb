def work()
  puts 'ha'
end

def loopf(n)
  i = 0
  while i < n
    yield i
    i += 1
  end
end

loopf 12 do |x|
  puts x
end
