import std.stdio;

void job(){
    writeln("hello?");
}

void job2(int d){
    writefln("data: %d", d);
}

void main() {
    job;
    job2(12);
}
