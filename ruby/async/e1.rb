require 'async'

# example function that takes a random amount of time to complete
def example(id)
  Async do |task|
    value = 5 + rand # get random value
    puts "Putting #{id} to sleep for #{value} seconds."
    task.sleep(value) 
    puts "#{id} woke up!"
  end
end

# asynchronously run five example functions
Async do
  5.times do |index|
    example(index)
  end
end
