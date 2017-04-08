require "socket"

class Server
  def start
    dts = UNIXServer.new("sock")

    loop do
      Thread.start(dts.accept) do |s|
        process(s)
        s.close
      end
    end

  end

  def process(s)
    msg = s.read
    puts "got: #{msg}"
    begin
      result = eval(msg)
    rescue Exception => e
      result = e.message
    end
    s.puts(result)
  end
end


Server.new.start
