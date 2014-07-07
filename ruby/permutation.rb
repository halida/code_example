# 18:11-18:29

t = [9, 0, 0, 0, 4, 0, 0, 0, 1]

def work
  [2,3,5,6,7,8].permutation.each do |v|
    v.insert(0, 9)
    v.insert(4, 4)
    v.push(1)
    # puts v.to_s

    if check(v)
      data = v
      puts "#{data[0..2].join} - #{data[3..5].join} = #{data[6..8].join}"
    end
  end
end

def check(data)
  a = data[0] * 100 + data[1] * 10 + data[2]
  b = data[3] * 100 + data[4] * 10 + data[5]
  c = data[6] * 100 + data[7] * 10 + data[8]

  # puts "#{a} - #{b} = #{c}"
  (a - b) == c
end


work
