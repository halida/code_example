#include <ruby.h>

float fib(int number){
    if (number <= 1){
        return 1;
    } else {
        float result = 0;
        result += fib(number-1);
        result += fib(number-2);
        return result;
    }
}


static VALUE
my_fib_native_fib(VALUE self, VALUE number) {
    int n = NUM2INT(number);
    float result = fib(n);

    return rb_float_new(result);
}

/*
 * This defines the C functions as extensions.
 *
 * The name of the Init_ function is important.  What follows Init_ must match
 * the file name (including case) so ruby knows what method to call to define
 * the extensions.
 */

void
Init_my_fib(void) {
    VALUE cMyFib;

    cMyFib = rb_const_get(rb_cObject, rb_intern("MyFib"));

    rb_define_singleton_method(cMyFib, "native_fib", my_fib_native_fib, 1);
}

