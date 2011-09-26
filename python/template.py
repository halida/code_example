#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: template
实验写一个模板引擎
"""
INDENT = u"    "

class Template():
    def __init__(self, s):
        self.level = 0
        if type(s) is str: s=s.decode('utf8')
        self.code = self.process(s)
        self.objcode = compile(self.code, '', 'exec')

    def partition(self, s, start, stop):
        first, p, last = s.partition(start)
        if not p: return first, p, last
        
        code, p, last = last.partition(stop)
        if not p: raise Exception('format error:', code)
        return first, code, last

    def process(self, s):
        codes = []
        while True:
            first, code, last = self.partition(s, '{{', '}}')
            if code:
                if first: codes.append(self.process_str(first))
                codes.append(self.process_code(code.strip()))
                s = last
                continue
            if s: codes.append(self.process_str(s))
            break
            
        return u"\n".join(codes)

    def process_str(self, s):
        code = ur"%swrite('''%s''')" % (u'    '*self.level, s)
        return code

    def process_code(self, code):
        tab = self.level
        if code[0] == '=':
            return u"%swrite(%s)" % (INDENT*self.level, code[1:])
        if code.startswith(u'for') or code.startswith(u'if'):
            code += u":"
            self.level += 1
        elif code.startswith(u'el'):
            code += u":"
            tab -= 1
        elif code == u'end':
            self.level -= 1
            return ""
        return u"%s%s" % (INDENT*tab, code)

    def render(self, **args):
        outs = []
        args['write'] = lambda v: outs.append(unicode(v))
        eval(self.objcode, args)
        return "".join(outs)

def test():
    """
    >>> class Info():
    ...     def __init__(self, n, d):
    ...         self.name, self.data = n, d
    
    >>> t1 = "{{=info.name}} : {{=info.data}}"
    >>> d1 = Info('ha', 12)
    >>> t = Template(t1)
    >>> print t.render(info=d1)
    ha : 12

    >>> t2 = "{{for info in infos}}{{= info.name }} : {{= info.data }}{{end}}"
    >>> infos = [Info("n%s"%i, i) for i in range(3)]
    >>> t = Template(t2)
    >>> print t.render(infos=infos)
    n0 : 0n1 : 1n2 : 2
    """
    import doctest
    doctest.testmod()
    

if __name__=="__main__":
    test()

