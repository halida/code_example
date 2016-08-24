class Finished < Exception
end
class NotMatch < Exception
end

def match(p, string)
  begin
    p.call(string, 0, eof)
  rescue NotMatch
    return false
  rescue Finished
    return true
  end
  raise "why quit?"
end

def log(*msg)
  puts msg.to_s
end

def eof
  lambda { |string, p|
    log 'eof', p
    raise Finished
  }
end

def seq(*fs)
  lambda { |string, p, _next|
    log 'seq', p
    ns = [_next]
    fs.reverse.each do |f|
      n = ns.last
      ns << lambda { |string, p|
        f.call(string, p, n)
      }
    end
    ns.last.call(string, p)
  }
end

def exact(s)
  lambda { |string, p, _next|
    log "exact", s, p
    if s != string[p]
      raise NotMatch
    else
      _next.call(string, p+1)
    end
  }
end

def includes(array)
  lambda { |string, p, _next|
    log "includes", array, p
    array.each do |d|
      l = d.length
      if string[p .. p+l-1] == d
        return _next.call(string, p+l)
      end
    end
    raise NotMatch
  }
end

def any(f)
  lambda { |string, p, _next|
    log 'any', p
    bind_f = lambda { |string, p|
      begin
        f.call(string, p, any(f))
      rescue NotMatch
        _next.call(string, p)
      end
    }
    bind_f.call(string, p)
  }
end

def at_least_one(f)
  lambda { |string, p, _next|
    log 'at_least_one', p
    bind_f = lambda { |string, p|
      any(f).call(string, p, _next)
    }
    f.call(string, p, bind_f)
  }
end


# /+(a|b|c)@*(ccc)
def code_version_match
  p = seq(
    at_least_one(includes('abc'.split(''))),
    exact('@'),
    any(exact('ccc')),
  )
  puts match(p, "a@ccc")
end

code_version_match
