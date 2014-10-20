require 'my_fib'
require 'benchmark'

count = 35

# run
puts MyFib.native_fib(count)
puts MyFib.ruby_fib(count)

puts "native"
puts Benchmark.measure{ MyFib.native_fib(count) }

puts "ruby"
puts Benchmark.measure{ MyFib.ruby_fib(count) }

