import std.stdio;

double fib(uint c){
    if (c <= 2) return 1;
    return fib(c-1) + fib(c-2);
}

void main(){
    uint [] counts = [1, 3, 5, 7, 9];
    foreach(c; counts){
        writefln("fib %d:\t%s", c, fib(c)); 
    }
}
