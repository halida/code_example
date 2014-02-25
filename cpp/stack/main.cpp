//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: main
//----------------------------------------------------------
#include <iostream>

template <class T> class Stack {
private:
    T * data;

public:
    unsigned int size;
    unsigned int inside = 0;

public:
    Stack(unsigned int size){
        this->size = size;
        data = static_cast<T *>( calloc(sizeof(T), size) );
    }
    
    ~Stack(){
        free(data);
    }

    void push(T t){
        *(data + inside) = t;
        this->inside ++;
    }

    T pop(){
        T result = *(this->get(this->inside - 1));
        this->inside --;
        return result;
    }

    T* operator[](unsigned int i){
        return this->get(i);
    }

    T* get(unsigned int i){
        if (i >= this->inside) return NULL;
        return (data + i);
    }

};


int main(int argc, char *argv[])
{
    Stack<int> s(10);
    for (int i = 0; i < 8; ++i)
        {
            s.push(i*10);
        }
    using namespace std;

    for (int i = 0; i < s.inside; ++i)
        {
            cout << *s[i] << endl;            
        }

    cout << "pop: " << s.pop() << endl;

    return 0;
}
