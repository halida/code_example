// this program simulate birth

class Widget{
    static Widget[] all;

    string type;
    Widget parent;

    this(Widget parent = null){
        this.parent = parent;
        this.type = "widget";
        Widget.all ~= this;
    }
    
    ~this(){
        Widget.all -= this;
    }
}

class Window : Widget{
    this(){
        super();
        this.type = "window";
    }
}

class Button : Widget{
    this(Widget parent){
        super(parent);
        this.type = "button";
    }
}

class OpWindow : Window{
    this(){
        super();
        foreach(i; 1..3){
            new Button(this);
        }
    }

    void close(){
    }
}

void main(){
    auto windows = [new OpWindow(), new OpWindow(), new Button()];
    windows[0].close();
    foreach(w; Widget.all){
        writefln("widget ID: %s\ttype: %s", w.id, w.type);
    }
}
