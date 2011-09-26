#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: calculator

l0 = (ltop) | n | NAME | - n | NAME ( function_args )
l1 = l1 * l0 | l1 / l0 | l0
l2 = l2 + l1 | l2 - l1 | l1
l3 = l2 < l2 | l2 > l2 | l2 == l2 | l2
ltop = l3

program = END | exp_list END
exp_list = exp_list ; exp
exp = ltop | assignment | condition | loop | function | return | outter_assignment

assignment = NAME = exp
outter_assignment = outter NAME = exp
condition = if ltop {exp_list} else {exp_list}
loop = while ltop {exp_list}

function = def NAME(function-args-names){exp_list}
function_args_names = function_args , NAME | NAME  | None
function_args = function_args , exp | exp | None
return_exp = return ltop
"""
import sys

class SyntaxException(Exception):
    pass

class ReturnException(Exception):
    """for implement return expression"""
    def __init__(self, v):
        Exception.__init__(self)
        self.value = v

def count(s):
    return Caculator(s)()

def syntax_analysis(s):
    """
    >>> syntax_analysis("1 + 1")
    [1, '+', 1]
    >>> syntax_analysis("2 * 3 + 1")
    [2, '*', 3, '+', 1]
    >>> syntax_analysis("2 * (3 + 1)")
    [2, '*', '(', 3, '+', 1, ')']
    >>> syntax_analysis("12 * sb + 1 * _s")
    [12, '*', 'sb', '+', 1, '*', '_s']
    >>> syntax_analysis("a = 12; a + 12")
    ['a', '=', 12, ';', 'a', '+', 12]
    >>> syntax_analysis("def cmp(a,b,c){a+b+c}; f(1, 2,3)")
    ['def', 'cmp', '(', 'a', ',', 'b', ',', 'c', ')', '{', 'a', '+', 'b', '+', 'c', '}', ';', 'f', '(', 1, ',', 2, ',', 3, ')']
    >>> syntax_analysis("def cmp(a,b){if (a>b) {return 1} ; if (a==b){return 0}; return 1}")
    ['def', 'cmp', '(', 'a', ',', 'b', ')', '{', 'if', '(', 'a', '>', 'b', ')', '{', 'return', 1, '}', ';', 'if', '(', 'a', '==', 'b', ')', '{', 'return', 0, '}', ';', 'return', 1, '}']

    """
    p = 0
    ls = []
    while p < len(s):
        if (p < len(s) - 1
            and s[p : p+2] == '=='):
            ls.append('==')
            p += 2
            continue
        if s[p] in '*+-/();=><{},':
            ls.append(s[p])
            p += 1
            continue
        elif s[p] in ' \t\n':
            p += 1
            continue
        elif s[p] in '0123456789.':
            d = []
            while  p < len(s) and s[p] in '0123456789.':
                d.append(s[p])
                p += 1
            d = ''.join(d)
            try:
                if '.' in d:
                    d = float(d)
                else:
                    d = int(d)
            except:
                raise SyntaxException('syntax error: value error on p %d: %s' % (p, d))
            ls.append(d)
            continue
        # NAME
        elif s[p] in 'abcdefghijklmnopqrstuvwxyz_':
            d = []
            while p < len(s) and s[p] in 'abcdefghijklmnopqrstuvwxyz_':
                d.append(s[p])
                p += 1
            ls.append(''.join(d))
            continue
    return ls

class Func():
    pass

def print_function(v):
    print v
    return v

class Env():
    def __init__(self, parent=None):
        self.values = {}
        self.parent = parent
        self.build_ins = {
            'p': print_function
            }

    def get_value(self, v):
        if v in self.values:
            return self.values[v]
        elif v in self.build_ins:
            return self.build_ins[v]
        elif not self.parent:
            raise SyntaxException('cannot find value: %s, current_values: %s' % (v, str(self.values)))

        return self.parent.get_value(v)

    def set_value(self, name, v):
        self.values[name] = v

    def set_outter_value(self, name, v):
        if name in self.values:
            self.values[name] = v
        elif self.parent:
            self.parent.set_outter_value(name, v)
        else:
            raise SyntaxException('cannot find outter value defination: %s' % name)

class Caculator():
    def __init__(self, s=None):
        self.env = Env()
        self.analysis(s)

    def analysis(self,s):
        self.p = 0
        if s:
            self.ls = syntax_analysis(s)
        else:
            self.ls = []

    def __call__(self, s=None):
        if s: self.analysis(s)
        return self.program()

    def has_next(self, v=0):
        return self.p < len(self.ls) - v

    def get(self, v=0):
        return self.ls[self.p + v]

    def inc(self):
        self.p += 1

    def issymbol(self, s):
        return (type(s) is str
                and s[0] in "abcdefghijklmnopqrstuvwxyz_")

    def isstr(self,s):
        return (type(s) is str)

    def goto_next_block(self):
        count = 1
        while self.has_next():
            if self.get() == '}':
                count -= 1
                if count <= 0: break
            elif self.get() == '{':
                count += 1
            self.inc()

    def error(self, msg):
        msg += ", at p %d: "%self.p + str(self.ls[self.p])
        raise SyntaxException(msg)

    def push_p(self, env, p, ls):
        self.env = env
        self.pre_p = self.p
        self.p = p
        self.pre_ls = self.ls
        self.ls = ls

    def pop_p(self):
        if self.env.parent == None:
            self.error('pop_p: no parent for env!')
        self.env = self.env.parent
        self.p = self.pre_p
        self.ls = self.pre_ls

    def function_call(self, func, args):
        # build_in function
        if not isinstance(func, Func):
            return func(*args)
        
        env = Env(self.env)
        for name, v in zip(func.arg_names, args):
            env.set_value(name, v)

        self.push_p(env, func.p, func.ls)

        try:
            v = self.exp_list()
            self.pop_p()
        except ReturnException as e:
            v = e.value

        return v

    def l0(self):
        if not self.has_next(): return
        g = self.get()
        if g == '(':
            self.inc()
            v = self.ltop()
            self.inc()
            return v
        elif (self.has_next(2)
              and self.issymbol(g)
              and self.get(1) == '('):
            func = self.env.get_value(g)
            self.inc()
            self.inc()
            args = self.function_args()
            
            if not self.get() == ')':
                self.error('l0 function call error')
            self.inc()

            return self.function_call(func, args)
            
        elif self.issymbol(g):
            self.inc()
            return self.env.get_value(g)
        elif self.has_next(1) and g == '-':
            self.inc()
            v = - self.ls[self.p]
            self.inc()
            return v
        else:
            self.inc()
            return g

    def l1(self):
        v = self.l0()
        while (self.has_next()
               and self.isstr(self.get())
               and self.get() in '*/'):
            if self.get() == '*':
                self.inc()
                v2 = self.l0()
                v *= v2
            elif self.get() == '/':
                self.inc()
                v2 = self.l0()
                if v2 == 0:
                    raise SyntaxException('divide by 0 from p: %d' % self.p)
                v /= v2
        return v

    def l2(self):
        v = self.l1()
        while (self.has_next()
               and self.isstr(self.get())
               and self.get() in '+-'):
            if self.get() == '+':
                self.inc()
                v2 = self.l1()
                v += v2
            elif self.get() == '-':
                self.inc()
                v2 = self.l1()
                v -= v2
        return v

    def l3(self):
        v = self.l2()

        if not self.has_next():
            return v
        
        if self.get() == '<':
            self.inc()
            v2 = self.l2()
            if v < v2: return 1
            else: return 0
        elif self.get() == '>':
            self.inc()
            v2 = self.l2()
            if v > v2: return 1
            else: return 0
        elif self.get() == '==':
            self.inc()
            v2 = self.l2()
            if v == v2: return 1
            else: return 0

        return v

    def ltop(self):
        return self.l3()
    
    def program(self):
        if self.has_next():
            return self.exp_list()

    def exp_list(self):
        v = self.exp()
        while self.has_next():
            if self.get() == ';':
                self.inc()
            if self.get() == '}':
                break
            v = self.exp()
            
        return v

    def exp(self):
        if self.has_next(1):
            if self.get(1) == '=':
                return self.assignment()
            elif self.get() == 'outter':
                return self.outter_assignment()
            elif self.get() == 'if':
                return self.condition()
            elif self.get() == 'while':
                return self.loop()
            elif self.get() == 'def':
                return self.function()
            elif self.get() == 'return':
                return self.return_exp()
            
        return self.ltop()

    def loop(self):
        self.inc()
        p = self.p
        while True:
            v = self.ltop()

            if self.get() != '{':
                self.error('exp error : no {')
            self.inc()

            if v > 0:
                v = self.exp_list()
            else:
                self.goto_next_block()
                    
            if self.get() != '}':
                self.error('exp error : not }')
            self.inc()

            if v <= 0:
                break
            else:
                self.p = p

        return v
                
    def assignment(self):
        name = self.get()
        self.inc()
        self.inc()
        v = self.exp()
        self.env.set_value(name, v)
        return v

    def outter_assignment(self):
        self.inc()
        name = self.get()
        self.inc()
        self.inc()
        v = self.exp()
        self.env.set_outter_value(name, v)
        return v

    def condition(self):
        self.inc()
        v = self.ltop()
        if self.get() != '{':
            self.error('exp error : no {')
        self.inc()
                
        if v > 0:
            v = self.exp_list()
        else:
            self.goto_next_block()
            
        if self.get() != '}':
            self.error('exp error : not }')
        self.inc()

        if self.has_next() and self.get() == 'else':
            self.inc()
            if self.get() != '{':
                self.error('exp error : no {')
            self.inc()
                        
            if v <= 0:
                v = self.exp_list()
            else:
                self.goto_next_block()

            if self.get() != '}':
                self.error('exp error : not }')
            self.inc()
        return v

    def function(self):
        func = Func()

        self.inc()
        
        name = self.get()
        if not self.issymbol(name):
            self.error('function error name : %s' % name)
        self.inc()
        func.name = name
        
        if self.get() != '(':
            self.error('function error not (')
        self.inc()

        func.arg_names = self.function_args_names()

        if self.get() != ')':
            self.error('function error not )')
        self.inc()

        if self.get() != '{':
            self.error('function error not {')
        self.inc()
        
        func.p = self.p
        func.ls = self.ls

        self.goto_next_block()
        
        if self.get() != '}':
            self.error('function error not }')
        self.inc()

        self.env.set_value(func.name, func)
        return func

    def function_args_names(self):
        arg_names = []
        while self.issymbol(self.get()):
            arg_names.append(self.get())
            self.inc()
            if self.get() != ',':
                break
            self.inc()
        return arg_names

    def function_args(self):
        args = []
        if self.get() == ')':
            return args

        args.append(self.exp())
        
        while (self.get() == ','):
            self.inc()
            args.append(self.exp())

        return args

    def return_exp(self):
        self.inc()
        v = self.exp()
        self.pop_p()
        raise ReturnException(v)

def test():
    """
    >>> count("1 + 1")
    2
    >>> count("2 * 9 + 1")
    19
    >>> count("2 * (3 + 1)")
    8
    >>> count("a = 12; a + 12")
    24
    >>> count(" - 12")
    -12
    >>> count(" 12 > 12")
    0
    >>> count(" if (12 > 11) { 12} else {11} ")
    12
    >>> count(" if (1 > 11) { 12} else {11} ")
    11
    >>> count(" if (1 > 11) { 12}")
    0
    >>> count(" if (1 > 11) { a = 12} else {a = 0}; a")
    0
    >>> count(" a = 12; a = a + 12")
    24
    >>> count("v = 0; i = 0; while i < 3 {v = v + 12; i = i + 1}; v")
    36

    >>> count("def f(a,b,c){a+b+c}") != 0
    True
    >>> count("def f(a,b,c){a+b+c}; f(1, 2,3)")
    6
    
    >>> c = Caculator("def cmp(a,b){if (a>b) {return 1} ; if (a==b) {return 0}; return -1}")
    >>> c() != 0
    True
    >>> c("cmp(1, 1)")
    0
    >>> c("cmp(1,2)")
    -1
    >>> c("cmp(2, 1)")
    1

    >>> c("def add(a, b){a + b}") != 0
    True
    >>> c("add(1, 2)")
    3
    """
    import doctest
    doctest.testmod()
    
if __name__=="__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == '--test':
            # run test
            test()
        else:
            # run file
            data = open(sys.argv[1]).read()
            print Caculator(data)()
    else:
        # iterative run caculator
        c =Caculator()
        try:
            while True:
                try:
                    s = raw_input('--> ')
                    print c(s)
                except SyntaxException as e:
                    print e
        except (EOFError, KeyboardInterrupt):
            print "bye!"
