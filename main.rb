require 'nokogiri'
require 'open-uri'
require 'mongoid'

# mongoid conf
Mongoid.load!("config/mongoid.yml", 'development')

# models
Dir["./models/*.rb"].each { |f| require f }

uploader = Uploader.new

save_to_db = lambda do |img_ele|
  origin_url = img_ele.attr 'src'

  if url = uploader.upload_with(origin_url)
    Photo.create origin_url: origin_url, url: url, type: 1
  end
end

#
begin
  doc = Nokogiri::HTML(open('http://tieba.baidu.com/p/1475769566'))
  doc.css('img.BDE_Image').each &save_to_db
rescue
end

#  http://loudatui.com/
#  page=21

(1..21).each do |n|
  begin
    doc = Nokogiri::HTML(open("http://loudatui.com?page=#{n}"))
    doc.css('a.img').each do |link|
      url = link.attr('href')
      detail = Nokogiri::HTML(open("http://loudatui.com#{url}"))
      detail.css('img.img').each &save_to_db
    end
    puts '-' * 50
  rescue
  end
end
#
# http://tieba.baidu.com/f?kw=%C3%C0%C5%AE&pn=0

i = -50
step = 50
loop do
  return if i > 50 * 100
  i += step
  base = "http://tieba.baidu.com"
  url = "#{base}/f?kw=%C3%C0%C5%AE&pn=#{i}"

  begin
    doc = Nokogiri::HTML(open(url))
    doc.css('.j_thread_list .threadlist_text > a').each do |link|
      url = "#{base}#{link.attr('href')}"
      detail = Nokogiri::HTML(open(url))
      detail.css('.l_post:first img.BDE_Image').each &save_to_db
    end
  rescue
    puts "error .... #{url}"
  end
end
