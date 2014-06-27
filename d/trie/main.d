import std.stdio;
import std.array;
import std.file;
import std.algorithm;

string [] extract_string(string filename) {
    auto content = cast(string) read(filename);
    auto result = split(content, "\n");
    return remove!("a.length <= 0")(result);
}

class Trie {
    string [] dict;

    this(string[] data){
        this.dict = data;
        sort(this.dict);
    }

    string [] search(string r){
        string [] result;
        auto hit = false;
        foreach(d; dict){
            if (std.string.indexOf(d, r) == 0) {
                hit = true;
                result ~= d;
            } else if (hit) break;
        }
        return result;
    }
}

class RealTrie {
    this(string[] data){
        ...
    }

    string[] search(string r){
        auto current = head;
        uint p = 0;
        foreach(c; r){
            // matching current node substring
            if (c == current.word[p+1]){
                p++;
                continue;
            }
            // match next node
            foreach(p; current.pointers){
                if (r == p) {
                    current = current.next[r];
                    p = 0;
                }
            }
            return 
        }
    }
}

void main() {
    writeln(extract_string("test_extract.txt"));
    auto ss = extract_string("dict.txt");
    auto t = new Trie(ss);
    auto result = t.search("au");
    writeln(result);
}


