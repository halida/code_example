require 'rbczmq'

class Client

  def initialize
    @ctx = ZMQ::Context.new

    @oper = @ctx.socket(:REQ)
    dir = File.expand_path(File.dirname(__FILE__))
    sock = File.join(dir, 'simple.sock')
    @oper.connect('ipc://#{sock}')
  end

  def op
    cmd = "hello"
    @oper.send(cmd)
    puts "result: #{@oper.recv()}"
  end

end

Client.new.op
