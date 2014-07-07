# understand about backtrace

class P
  def caller
    lambda {
      q = Q.new
      q.call
    }
  end
end

class Q
  def call
    begin
      1 / 0
    rescue Exception => e
      puts e.backtrace.to_s
    end
  end
end

def call
  1.times.each do
    p = P.new
    p.caller.call
  end
end

call
