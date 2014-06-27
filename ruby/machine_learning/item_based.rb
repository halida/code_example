data = {1: [5140, 3123], 2: [1213, 5140]}

def process
  si = caculate_simular_table
  idea_id = 1
  result = max_simular(si, idea_id)
  puts "max simular idea of #{idea_id} is : #{result}"
end

def max_simular si, item_id
  si[item_id].items.sort_by{|v| v[1]}.reverse[0][0]
end

def caculate_simular_table
  si = {}
  items.each do |i|
    si[i] = {}
    items.each do |j|
      s = simular(a, b)
      si[j] = s
    end
  end
  si
end

def simular a, b
  ??
end
