extern (C) int strcmp(char* string1, char* string2);

import std.string;
int myDfunction(char[] s) {
  return strcmp(std.string.toStringz(s), "foo");
}

void main() {
    auto v = myDfunction();
    writeln(v);
}
