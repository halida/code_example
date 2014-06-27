def work name, *values, type: "all"
  puts "#{name} is working on #{type}"
  puts "values: #{values}"
end

work('halida', type: 'coding')
