%Module word 0

class Word {

%TypeHeaderCode
#include <word.hpp>
%End

public:
    Word(const char *w);

    char *reverse() const;
};