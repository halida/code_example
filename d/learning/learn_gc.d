import std.stdio;

class DGC { 
    char[] data;
    this(){
        data = new char[2000];
    }
}

void load_memory (){
    DGC[100000] l;
    foreach(i; 0..(l.length) ){
        auto d = new DGC();
        l[i] = d;
        destroy(d);
    }
}

void load_obj(){
    auto d = new DGC();
}

void main() {
    // load_memory();
    foreach(i; 0..1000000) load_obj();

    char[] buf;
    stdin.readln(buf);
}
