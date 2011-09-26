def qsort(list)
  return [] if list.size == 0
  x, *xs = *list
  less, more = xs.partition{|y| y < x}
  qsort(less) + [x] + qsort(more)
end


def bubble_next(list)
  if list.size < 2 then
    return list 
  end

  0.upto(list.size - 2) do |i|
    if list[i] > list[i+1] then
      list = Array.new(list)
      list[i], list[i+1] = list[i+1], list[i]
      return list
    end
  end

  list
end

p qsort([1, 3, 5, 2, 4, 6])

p bubble_next([1,3,2])

next_seq = [3, 2, 7, 4, 0, 6, 1]
begin
  seq = next_seq
  next_seq = bubble_next(seq)
  p next_seq
end while seq != next_seq
