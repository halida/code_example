import std.stdio;

void main(){
    immutable inchesPerFoot = 12;
    immutable cmPerInch = 2.54;

    foreach (feet; 5 .. 7) {
        foreach (inches; 0 .. inchesPerFoot) {
            writefln("%d'%d''\t%3.3f", feet, inches,
                    (feet * inchesPerFoot + inches) * cmPerInch);
        }
    }
}
