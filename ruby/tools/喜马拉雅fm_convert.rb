# coding: utf-8
# 喜马拉雅fm
# 首先用windows10客户端下载下来
# https://www.zhihu.com/question/48193463
# 然后用这个脚本改正名字
require 'json'

def convert(id)
  # id = '12510648'
  data = JSON.load(File.read("#{id}list.json"))
  # data.map{|d|d['title']}
  FileUtils.mkdir_p('mp3')
  FileUtils.mkdir_p('title')

  data.each_with_index do |d, i|
    old_filename = "#{id}/#{ d['trackId'] }.m4a"
    new_filename = "title/#{i}_#{ d['title'] }.m4a"
    new_mp3_filename = "mp3/#{File.basename(new_filename, '.m4a')}.mp3"

    next unless File.exists?(old_filename)

    unless File.exists?(new_filename)
      FileUtils.copy(old_filename, new_filename)
    end

    unless File.exists?(new_mp3_filename)
      `avconv -i "#{new_filename}" -acodec mp3 "#{new_mp3_filename}"`
    end
  end

end
