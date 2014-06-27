import std.stdio;

class Queue (T){
    enum R { OK, ERR_FULL, ERR_EMPTY };

    T [] container;
    uint pin = 0, pout = 0, size = 0;

    this(uint queue_size){
        size = queue_size;
        container = new T[queue_size + 1];
    }

    R push(T value){
        auto n = next(pin);
        if (n == pout) return R.ERR_FULL;

        container[pin] = value;
        pin = n;
        return R.OK;
    }

    R pop(ref T value){
        if (pin == pout) return R.ERR_EMPTY;
        
        value = container[pout];
        pout = next(pout);
        return R.OK;
    }

    private
    uint next(uint n) {
        return (n + 1) % container.length;
    }
}

void main() {
    auto q = new Queue!int(10);
    foreach(i; 0 .. 10) {
        assert (q.push(i) == q.R.OK);
    }

    assert (q.push(10) == q.R.ERR_FULL);

    int d;
    foreach(i; 0 .. 10) {
        assert (q.pop(d) == q.R.OK);
    }
    assert (q.pop(d) == q.R.ERR_EMPTY);
}
