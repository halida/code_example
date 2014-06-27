import std.stdio, std.string;

void main(){
    uint[string] d;
    foreach (line; stdin.byLine()){
        foreach(word; split(strip(line))){
            if (word in d) continue;
            auto newID = d.length;
            d[word] = newID;
            writeln(newID, "\t", word);
        }
    }
}
