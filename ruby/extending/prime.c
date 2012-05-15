//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: prime
//----------------------------------------------------------
#include "ruby.h"
#include <stdbool.h>

int primes[1000];
int count_to = 0;

void
define_primes(VALUE cPrime)
{
  VALUE arr;

  primes[0] = 2;
  primes[1] = 3;
  primes[2] = 5;
  count_to = 2;
}

static VALUE
t_index(VALUE self, VALUE value_index)
{
  VALUE arr;
  int index = NUM2INT(value_index);

  while (count_to < index){
      bool not_prime = true;

      for(int v = primes[count_to]+1; not_prime; v++) {
          not_prime = false;

          for(int i=0; i<=count_to; i++){
              if(v % primes[i] == 0){
                  not_prime = true;
                  break;
              }
          }

          if(not_prime) continue; 
          count_to++;
          primes[count_to] = v;
      }
  }

  return INT2NUM(primes[index]);
}

VALUE cPrime;

void Init_Prime() {
  cPrime = rb_define_class("Prime", rb_cObject);
  define_primes(cPrime);
  rb_define_singleton_method(cPrime, "index", t_index, 1);
}
