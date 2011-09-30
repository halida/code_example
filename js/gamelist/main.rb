# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require 'sass'
require 'coffee-script'
require 'redis'

$redis = Redis.new

set :port, 8182
# set :environment, :production

not_found do
  @title = "404"
  myhaml :not_found
end

error do
  @title = "error.."
  myhaml :error
end

get '/' do
  myhaml :index 
end

Dir.new(File.dirname(__FILE__) + '/views').find_all do |file|
  extname = File.extname file
  basename = File.basename file, extname
  (puts "haml: #{basename}"; get("/#{basename}"    ){myhaml basename.to_sym}) if extname == '.haml' and not ['layout'].member? basename
  (puts "css : #{basename}"; get("/#{basename}.css"){sass   basename.to_sym}) if extname == '.sass'
  (puts "js  : #{basename}"; get("/#{basename}.js" ){coffee basename.to_sym}) if extname == '.coffee'
end

def myhaml target, args={}
  args.merge! :layout => false if params[:_pjax]
  haml target, args
end

def link_to name, link, pjax=""
  pjax = "class=\"js-pjax\"" unless pjax == ""
  "<a href=\"#{link}\"#{pjax}>#{name}</a>"
end

