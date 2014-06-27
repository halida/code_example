import std.stdio;
import quick_sort;

void check(int [] list){
    writeln("sort:\t", list);
    quicksort(list);
    writeln("result:\t", list);
}

void main(){
    check([-9, 8, 7, -6, 3, 1, -2, 4, 5]);
}
