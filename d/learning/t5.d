interface Stat {
    void accumulate(double x);
    void postprocess();
    double result();
}

class Min : Stat {
    private double min = double.max;

    void accumulate(double x){
        if(x >= min) return;
        min = x;
    }

    void postprocess(){}

    double result(){
        return min;
    }
}

import std.stdio;

void main(string[] args){
    Stat [] stats;
    foreach (arg; args[1..$]){
        auto newStat = cast(Stat) Object.factory("stats." ~ arg);
        assert(newStat, "Invalid Statistics function: " ~ arg);
        stats ~= newStat;
    }

    for (double x; readf(" %s ", &x) == 1; ) {
        foreach(s; stats){
            s.accumulate(x);
        }
    }

    foreach (s; stats){
        s.postprocess();
        writeln(s.result());
    }
}
