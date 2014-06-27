import std.stdio;
import std.random;

class Obj {
    int id;
    string value;

    this(){
        id = uniform(0, 1000000);
        writeln("creating obj: %d", id);
    }

    ~this(){
        writeln("deleting obj: %d", id);
    }

    Obj copy(){
        Obj o = new Obj();
        o.value = this.value;
        return o;
    }

    void show_value(){
        writefln("value: %s", value);
    }
}

void working_on(Obj c){
    c.value = "hfdsa";
}

void main() {
    auto c = new Obj;
    working_on(c);
    auto p = c.copy();
    p.show_value();
}
