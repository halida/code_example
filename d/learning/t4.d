import std.stdio, std.string;

struct Contact{
    uint id;
    string name; 
    string phone;
    string[] addresses;
};

void main(){
    Contact[10] book;
    Contact a;
    a.id = 1;
    a.name = "halida";
    a.phone = "13611984230";
    string[] addrs = ["home", "home2"];
    a.addresses = addrs;
    book[0] = a;

    showContact(a);
}

void showContact(Contact c){
    writeln("id:\t", c.id);
    writeln("name:\t", c.name);
    writeln("addr:\t", c.addresses);
}
