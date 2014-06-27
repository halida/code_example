import std.stdio;

template fib(uint c){
    static if (c <= 2) const fib = 1;
    // fib(c-1) + fib(c-2);
}

void main(){
    writeln("fib ", 10, ", ", fib(10));
    // uint [] counts = [1, 3, 5, 7, 9];
    // foreach(c; counts){
    //     writefln("fib %d:\t%s", c, fib(c)); 
    // }
}
