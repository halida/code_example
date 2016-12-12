def run
  twos = Fiber.new do
    num = 2
    while true do
      Fiber.yield(num) unless num % 3 == 0
      num += 2
    end
  end
  10.times { print twos.resume, " " }
end

def run_as_workers
  jobs = (1..10).to_a
  done = []

  fibs = (1..3).map do |i|
    Fiber.new do
      Fiber.yield
      while not jobs.empty?
        k = jobs.pop
        done << k*k
        puts "fiber#{i} working on #{k}"
        Fiber.yield
      end
    end
  end

  while not jobs.empty?
    fibs.sample.resume
  end
end


def run_with_thread_workers
  jobs = (1..10).to_a
  done = []

  fibs = (1..3).map do |i|
    Fiber.new do
      Fiber.yield

      while not jobs.empty?
        k = jobs.pop
        puts "#{Time.now} fiber#{i} working on #{k}"

        thread = Thread.new {sleep(3); k*k}
        while thread.status != false
          Fiber.yield
          sleep(0.1)
        end

        thread.join
        done << thread.value
        puts "#{Time.now} fiber#{i} done #{k}"
      end
    end
  end

  while not jobs.empty?
    fibs.sample.resume
  end
  
end

def error
  fiber = Fiber.new do
    Fiber.yield
    sleep(1)
    a = 1 / 0
    sleep(1)
    12
  end

  fiber.resume
end
