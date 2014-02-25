#include "tk.h"
#include "stdio.h"

void hello() {
     puts("Hello C++/Tk!");
}

int main(int, char *argv[])
{
     init(argv[0]);
     button(".b") -text("Say Hello") -command(hello);
     pack(".b") -padx(20) -pady(6);
}
