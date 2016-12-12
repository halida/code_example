def run
  threads = (1..12).map do |i|
    Thread.new do
      puts "calculate #{i}"
      while true
        sleep(rand * 3)
      end
      puts "calculating: #{i}"
    end
  end

  threads.map(&:join)
  puts "OK"
end

def run_break
  begin
    done = false
    threads = (1..12).map do |i|
      Thread.new do
        puts "thread##{i} is running"
        j = 0
        while true
          sleep(rand * 5)
          puts "thread##{i} calculate: #{j}"
          j += 1
          break if done
        end
        puts "thread done"
      end
    end
    threads.map(&:join)
  ensure
    done = true
  end
  puts "OK"
end

def run_with_lock
  i = 0

  get_i = lambda {i}
  set_i = lambda {|v| i = v}

  semaphore = Mutex.new
  with_lock = lambda { |&block|
    semaphore.synchronize {
      block.call
    }
  }
  
  threads = (1..20).map do |j|
    Thread.new do
      sleep(rand*3)
      with_lock.call do
        i = get_i.call
        puts "calculate #{j}"
        sleep(rand * 2)
        i += 1
        set_i.call(i)
        puts "calculate OK: #{j}, i: #{i}"
      end
    end
  end

  threads.map(&:join)
  puts "OK"
end

def error_thread
  thread = Thread.new do
    sleep(1)
    a = 1 / 0
    sleep(1)
    12
  end
  thread.join
  thread.value # will got error
end
  
run
