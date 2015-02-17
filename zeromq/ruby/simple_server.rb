# -*- coding: utf-8 -*-
require 'rbczmq'

class Server

  def initialize
    @ctx = ZMQ::Context.new

    @oper = @ctx.socket(:REP)
    dir = File.expand_path(File.dirname(__FILE__))
    sock = File.join(dir, 'simple.sock')
    @oper.bind('ipc://#{sock}')
  end

  def loop
    while true
      sleep(0.01)
      check_op
    end
  end

  def check_op
    begin
      cmd = @oper.recv(:NOBLOCK).strip
    rescue ZMQ::Error
      # 处理完所有命令就跳出命令处理逻辑
      return
    end

    @oper.send("hello #{result}")
  end


end


Server.new.loop
