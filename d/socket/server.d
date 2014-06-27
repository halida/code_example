#!/usr/bin.rdmd
import std.stdio;
import std.socket;
import std.string;
import std.conv;
import core.thread;

int main(string[] args) {
    if (args.length != 2) {
        writefln("usage: %s <port>",args[0]); 
        return 0;
    }

    auto s = new TcpSocket();
    s.blocking(true);

    auto addr = new InternetAddress("localhost", to!ushort(args[1]));
    s.bind(addr);
    s.listen(1);

    while (true){
        auto n = s.accept();
      
        char [] recv_buf;
        n.receive(recv_buf);

        writefln("Received: %s\n", recv_buf);
        n.send(recv_buf);

        n.close();
    }

    writeln("sent");

    return 0;
}
