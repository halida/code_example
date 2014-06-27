import std.array;
import std.stdio;

struct People{
    string name;
    uint age;
}

struct Arm{
    ulong from;
    ulong to;
}

class HierarchyTree{
    People *[] items;
    Arm [] arms;

    int add(People * top, People * down){
        // check top exists
        auto seq = this.index(top);
        if (seq < 0) return -1;

        // insert item
        items ~= down;
        auto to = items.length-1;

        // insert arm
        if (top != null) {
            Arm a = {from: seq, to: to};
            arms ~= a;
        }

        return 0;
    }

    ulong index(People * item){
        ulong i = 0;
        foreach(it; items){
            if(item == it) return i;
            i++;
        }
        return -1;
    }

    void show(People * item=null, uint indent=0){
        if (item == null) item = items[0];

        for(int i=0; i<indent*4; i++) write(" ");
        writefln("name: %s", item.name);

        auto index = this.index(item);
        foreach(p; arms) {
            if (p.from == index){
                this.show(this.items[p.to], indent + 1);
            }
        }
    }
}

void main() {
    auto tree = new HierarchyTree();
    People boss = {name: "boss", age: 42};

    People m1 = {name: "steven", age: 32};
    People m2 = {name: "bob", age: 36};

    People b1 = {name: "karl", age: 32};
    People b2 = {name: "jack", age: 30};
    People b3 = {name: "mark", age: 26};
    People b4 = {name: "stone", age: 25};
    People b5 = {name: "read", age: 24};

    tree.add(null, &boss);
    tree.add(&boss, &m1);
    tree.add(&boss, &m2);

    tree.add(&m1, &b1);
    tree.add(&m1, &b2);
    tree.add(&m1, &b3);

    tree.add(&m2, &b4);
    tree.add(&m2, &b5);

    tree.show();
}
