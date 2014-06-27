module quick_sort;

void quicksort(ref int [] list){
    if (list.length < 2) return;

    auto mid = list[0];
    ulong s=0;

    foreach (e; 1 .. list.length) {
        if (list[e] < mid) {
            swap(list, s, e);
            s++;
        }
    }
    quicksort(list[0 .. s]);
    quicksort(list[s+1 .. $]);
}

void swap(int [] list, ulong a, ulong b){
    int t = list[a];
    list[a] = list[b];
    list[b] = t;
}

unittest{
    auto v = [];
    quicksort(v);
    assert(v == []);

    auto d = [3, 2, 1, 5, 4];
    quicksort(d);
    assert(d == [1, 2, 3, 4, 5]);
}
