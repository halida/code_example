class LinkedArray (T) {
    enum R {OK, E_OUT_RANGE};

    Struct Node {
        T data;
        Node * next;
    }

    Node *head, *tail;

    this(){
        head = new Node;
        head.next = null;
        tail = head;
    }

    void add(T d){
        append(tail, d);
    }

    R insert(uint index, T d){
        Node *c = index_to_pre(index);
        if (c == null) return R.E_OUT_RANGE;

        Node *n = append(c, d);        
    }

    T delete(uint index){
        Node * c = index_to_pre(index);
        if (c == null) return R.E_OUT_RANGE;

        Node * n = c.next;
        if (c.next == null) return R.E_OUT_RANGE;

        c.next = n.next;
        if (c.next == null) tail = c;
        destroy(n);
    }

    private

    Node * index_to_pre(uint index){
        Node *c = head;
        foreach(i; 0 .. index){
            c = c.next;
            if (c == null) return null;
        }
        return c;
    }

    Node * append(Node *h, T d){
        auto n = new Node(d, h.next);
        h.next = &n;
        if (n.next == null) tail = n;
        return &n;
    }
}

void main() {
    auto la = LinkedArray!(int);

    foreach(i; 0..10) la.add(i);

    la.delete(3);
    assert(la.index(3) == 3);

    la.insert(6, 12);
    assert(la.index(6) == 12);
}
