class Array
  def inject(n)
    each { |value| n = yield(n, value) }
    n
  end

  def sum
    inject(0) { |n, value| n + value }
  end

  def product
    inject(1) { |n, value| n * value }
  end

  def reduce(func, result=0)
    each do |value|
      result = func.call(result, value)
    end
  end

end

def add(a, b)
  a + b
end

s = [1,2,3,4,5]
puts "sum: #{s.sum}"
puts "product: #{s.product}"
puts "reduce sum: #{s.reduce(method(:add), 0)}"


