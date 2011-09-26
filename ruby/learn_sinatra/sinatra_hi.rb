require 'sinatra'
require 'haml'

get '/hi' do
  "hello, asshole!"
end

get '/hello/:name' do
  "<h1>hello #{params[:name]}</h1>"
end

get '/say/*/to/*' do
  sth, sb = params[:splat]
  "hey #{sb}, you got this: #{sth}"
end

get '/' do
  haml :bubble_intro
end

get '/bubble' do
  haml :bubble_intro
end

get '/bubble/:seq' do
  @seq = params[:seq].split ','
  @next = bubble_next(@seq)
  @seq = @seq.join ','
  @next = @next.join ','
  if @seq == @next then
    @msg = "bubble sort done!"
  else
    @msg = ""
  end
  haml :bubble
end

def bubble_next(list)
  if list.size < 2 then
    return list 
  end

  0.upto(list.size - 2) do |i|
    if list[i] > list[i+1] then
      list = Array.new(list)
      list[i], list[i+1] = list[i+1], list[i]
      return list
    end
  end

  list
end
