require './lib'

class Client

  def start
    require 'socket'
    s = TCPSocket.new( "localhost", 20000 )

    listener = listen(s)
    sender = send(s)

    listener.join
    sender.join

    puts "\nbye~"
    s.close
  end

  def listen(s)
    Thread.new do
      loop do
        msg = s.gets.chomp
        puts "\nresult: #{msg}\n"
      end
    end
  end

  def send(s)
    Thread.new do
      run_prompt do |text|
        break if text == 'exit'
        s.puts(text)
      end
    end
  end

  def run_prompt
    begin
      while text = prompt("> ")
        yield(text)
      end
    rescue SystemExit, Interrupt => e
    end
  end
    
  def prompt(text)
    print text + ' '
    text = gets.strip
  end
end

Client.new.start
