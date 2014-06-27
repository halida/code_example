require 'socket'

gs = TCPServer.open(8111)
socks = [gs]
addr = gs.addr
addr.shift
puts "server is on #{addr.join(':')}"

while true
  nsock = select(socks)
  next if nsock == nil
  for s in nsock[0]
    if s == gs
      socks.push(s.accept)
      puts "#{s} is accepted"
    else
      begin
        if s.eof?
          puts "#{s} is gone"
          s.close
          socks.delete(s)
        else
          str = s.gets
          puts "received: #{str}"
          s.write(str)
          if str.strip == 'EOF'
            s.close
            socks.delete(s)
          end

        end
      rescue Exception => e
        puts "#{s} error: #{e.message}"
        s.close
        socks.delete(s)
      end
    end
  end
end

