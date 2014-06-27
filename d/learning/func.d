import std.stdio;

// auto function op(function int(int a, int b) f, int a, int b){
//     return f(a, b);
// }

void main() {
    auto d = function(int a, int b){ return a + b; };
    auto result = d(12, 13);
    writeln("result: ", result);
}
