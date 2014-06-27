require 'nokogiri'
require 'open-uri'

def crawl
  url = "http://movie.douban.com/people/linjunhalida/wish"

  doc = Nokogiri::HTML(open(url, "User-Agent" => DEFAULT_UA))
  links = doc.search('a[href]').map{ |link| link['href']}
  usernames = links.select{|l| l.starts_with?('/member')}.map{|v| v.split("/").reject(&:empty?)[-1]}.uniq
  usernames.each{|u| Resque.enqueue V2exCrawlUser, u}
end

