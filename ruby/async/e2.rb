require 'async'

# example function that takes a random ammount of time to complete
# now with a timeout
def example(id)
  Async do |task|
    task.with_timeout(2.5) do
      value = rand *5 # get random value
      puts "Putting #{id} to sleep for #{value} seconds."
      task.sleep(value)
      puts "#{id} woke up!"
    rescue Async::TimeoutError
      puts "#{id} timed out!"
    end
  end
end

# asynchronously run five example functions
Async do
  5.times do |index|
    example(index)
  end
end
