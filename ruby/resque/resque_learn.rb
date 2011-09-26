require 'resque'
require 'resque_scheduler/tasks'

def add
  id = rand(1000)
  n = 4
  Resque.enqueue(Caculator, id, n)
end

class Caculator
  @queue = :caculator

  def self.perform id, n
    puts "id: #{id} caculate #{n}"
    return if n <= 0
    Resque.enqueue_at(Time.now + 5, Caculator, id, n-1) # run SomeJob at a specific time
    puts "enque.."
  end
end

class Tick
  @queue = :tick
  def self.perform
    puts "tick #{Time.now}"
  end
end

