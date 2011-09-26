//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: word
//----------------------------------------------------------
#ifndef __WORD_HPP__
#define __WORD_HPP__

class Word{
    const char *the_word;

public:
    Word(const char *w);
    char *reverse() const;
};

#endif

