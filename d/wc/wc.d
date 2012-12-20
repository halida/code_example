import std.stdio;
import std.ascii;

auto USAGE = "
NAME
\twc -- count words

SYNOPSIS
\twc [-l]

DESCRIPTION
\tCount Words.

\tOptions available:

\t-l\tCount line.

AUTHOR
\tlinjunhalida<linjunhalida@gmail.com>
";

void main(string[] args) {
    ulong result;
    foreach (arg; args){
        if (arg == "-l") {
            result = count_letter('\n');
            writeln(result);
            return;
        }
    }
    result = count_by(function bool(uint c){ return isAlphaNum(c); });
    writeln(result);
}


enum State {IN, OUT};

ulong count_by(bool function(uint c) check){
    State state = State.OUT;
    uint c;
    ulong wc;
    while(true){
        c = getchar();
        if (c == EOF) break;

        if (check(c)) {
            if (state == State.OUT) {
                state = State.IN;
            } 
        } else {
            if (state == State.IN) {
                state = State.OUT;
                wc ++;
            }
        }
    }
    if (state == State.IN) {
        wc ++;
    }

    return wc;
}


ulong count_letter(uint l){
    ulong lc;
    int c;
    while(true){
        c = getchar();
        if (c == EOF) break;
        if (c == l) lc++;
    }
    return lc;
}
