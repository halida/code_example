require './lib'

class Server

  def start
    require "socket"
    dts = TCPServer.open('localhost', 20000)
    log("starting server..")

    loop do
      Thread.start(dts.accept) do |s|
        log("start: #{s.addr}")
        self.process(s)
        log("ending: #{s.addr}")
        s.close
      end
    end
  end

  def process(s)
    loop_command(s) do |cmd|
      log("got: #{cmd}")
      result = run(cmd)
      log("result: #{result}")
      s.puts(result)
    end
  end

  def loop_command(s)
    begin

      while true
        begin
          out = s.gets
        rescue EOFError => e
          # end of socket
          break
        end
        yield(out)        
      end

    rescue Exception => e
      puts "loop run error: \n#{e.message}\n#{e.backtrace.join("\n")}"
    end
  end

  def run(cmd)
    begin
      eval(cmd)
    rescue Exception => e
      "run command error: \n#{e.message}\n#{e.backtrace.join("\n")}"
    end
  end

  def log(msg)
    puts "#{Time.now}\t#{msg}"
  end

end

Server.new.start
