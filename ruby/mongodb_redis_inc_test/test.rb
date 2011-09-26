require 'redis'
require 'mongo'

def test_redis n
  $redis = Redis.new
  $redis.set 'test_n', 0
  n.times.each { $redis.incr 'test_n' }
end

def test_mongo n
  $db = Mongo::Connection.new.db('test')
  c = $db['tt']
  c.insert 'test_n' => 0
  n.times.each { c.update({}, {'$inc' => {'test_n' => 1}}) }
end

def check_time &block
  t = Time.now
  block.call
  t2 = Time.now
  t2 - t
end

n = 1000000
t = check_time {test_mongo n}
puts "mongo: #{t}"

t = check_time {test_redis n}
puts "redis: #{t}"
