import std.stdio;

void process(ref int a){
    a = a * a;
}

void main(){
    int a = 12;
    process(a);
    writefln("a is: %s", a);
}

