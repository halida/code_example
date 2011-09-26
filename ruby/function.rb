def shows(a1="a", a2="b", a3="c", *rest)
  "#{a1}, #{a2}, #{a3}, #{rest.join ', '}"
end

p shows 'c', 'd'

p shows 'c'

p shows '1', '1', '1', '1', '1', '1'

def job()
  p 12
end

def upTo(n)
  s = 0
  yield s
  s += 1
  if s = n then return end
end

upTo 12 do
  p "?"
end

def tell(p)
  "#{p[:name]} is #{p[:age]} years old"
end

p tell :name => "halida", :age => 12


class Song
  def initialize(name, artist, duration)
    @name     = name
    @artist   = artist
    @duration = duration
  end
end


aSong = Song.new("Bicylops", "Fleck", 260)
p aSong.inspect
p aSong.to_s

class Song
  def to_s
    "Song: #{@name}--#{@artist} (#{@duration})"
  end
end

aSong = Song.new('bbb', 'fff', 20)
p aSong.to_s

class Song
  attr_reader :name, :artist, :duration
end

p aSong.name

class Song
  def duration=(nv)
    @duration = nv * 1.2
  end
end

aSong.duration = 12
p aSong.duration

class Song
  @@plays = 0
  def initialize(name, artist, duration)
    @name     = name
    @artist   = artist
    @duration = duration
    @plays    = 0
  end
  def play
    @plays += 1
    @@plays += 1
    "This  song: #@plays plays. Total #@@plays plays."
  end
end

aSong = Song.new 'a', 'aaa', 1
p aSong.play
bSong = Song.new "b", "bbb", 120
p bSong.play


