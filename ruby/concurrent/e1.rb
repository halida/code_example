require 'net/http'
require 'concurrent-ruby'

class Browser
  include Concurrent::Async

  def render_page(link)
    puts "start: #{link}"
    sleep 5
    body = Net::HTTP.get( URI.parse(link) )
    File.open(filename(link), 'w') { |file| file.puts(body)}
  end

  private

  def filename(link)
    "#{link.gsub(/\W/, '-')}.html"
  end
end

pages = [
  'https://www.bing.com',
  'https://www.baidu.com'
].map{ |link| Browser.new.async.render_page(link) }.map(&:value)
