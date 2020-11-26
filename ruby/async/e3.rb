require 'async'

Async do
  sleepy = Async do |task|
    task.sleep 1000
  end
  
  sleepy.stop
end
