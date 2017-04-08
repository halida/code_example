require 'socket'

class Client
  def start
    s = UNIXSocket.open('sock')
    s.puts "12 + 13"
    s.flush
    s.read
    s.close
  end
end

Client.new.start
