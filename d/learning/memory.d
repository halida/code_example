import std.stdio;
import std.c.stdlib;

void alloc(){
    char [] d;
    d = new char[1000];
    writefln("size: %d", d.length);
}

struct Block {
    char [1000] data;
    Block * next;
}

void memory_leak(){
    auto b = new Block;
    Block *p = b;
    foreach(i; 0 .. 1000){
        p.next = new Block;
        p = p.next;
    }
    p.next = b; // circuit reference
}

void real_memory_leak(){
    auto b = cast(Block*)calloc(1, Block.sizeof);
}

void main() {
    foreach(i; 0..1000000){
        real_memory_leak();
    }

    char[] buf;
    stdin.readln(buf);
}
