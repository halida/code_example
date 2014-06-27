#!/usr/bin.rdmd
import std.stdio;
import std.socket;
import std.string;
import std.conv;
import std.random;
import std.outbuffer;
import core.thread;

int main() {
  auto s = new TcpSocket();
  // s.blocking(true);

  auto addr = new InternetAddress("localhost", 8111);
  s.connect(addr);

  // char [] data;
  // long r = s.send("hello");
  // writefln("send byte: %d", r);
  long r = s.send(cast(void[])"hello socket world");
  writefln("%d bytes sent.", r) ;

  Thread.sleep( dur!("seconds")( 1 ) );

  char [] data;
  r = s.receive(data);
  writefln("receive byte: %d", r);
  // writeln(data);

  s.close();
  return 0;
}
