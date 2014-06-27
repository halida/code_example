def prompt(text)
  print text + ' '
  text = gets.strip
end


class Client
  def start
    require 'socket'
    s = TCPSocket.new( "localhost", 20000 )

    while text = prompt("> ")
      break if text == 'exit'
      s.write(text + "\n")
      sleep 1
      puts s.read
      # puts s.recv_nonblock(1024)
    end
    s.close
  end
end

Client.new.start
