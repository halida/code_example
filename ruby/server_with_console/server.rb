def prompt(text)
  print text + ' '
  text = gets.strip
end

class Debuger
  def start
    require "socket"
    dts = TCPServer.new('localhost', 20000)

    loop do
      Thread.start(dts.accept) do |s|
        puts "#{Time.now}\tstart: #{s.addr}"
        self.process(s)
        puts "#{Time.now}\tending: #{s.addr}"
        s.close
      end
    end
  end

  def process(s)
    while not s.eof? and cmd = s.readline
      result = eval(cmd)
      puts "on result: #{result}"
      s.write(result)
    end
  end
end

# t = Thread.new{ Debuger.new.start }

# while text = prompt('>')
#   puts ": #{text}"
# end

Debuger.new.start
