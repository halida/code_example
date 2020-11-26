#!/usr/bin/env ruby

require 'async'
require 'async/barrier'
require 'async/http/internet'

TOPICS = ["ruby", "python", "rust"]

Async do
  internet = Async::HTTP::Internet.new
  barrier = Async::Barrier.new
  
  # Spawn an asynchronous task for each topic:
  TOPICS.each do |topic|
    barrier.async do
      response = internet.get "https://www.bing.com/search?q=#{topic}"
      puts "Found #{topic}: #{response.read.scan(topic).size} times."
    end
  end
  
  # Ensure we wait for all requests to complete before continuing:
  barrier.wait
ensure
  internet&.close
end
