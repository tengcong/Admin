require 'nokogiri'
require 'open-uri'
require 'mongoid'

# mongoid conf
Mongoid.load!("config/mongoid.yml", 'development')

# models
Dir["./models/*.rb"].each { |f| require f }


BASE = "http://www.qqtn.com"
SURFIX = ".html"
PATHS = [
  "/bq/fuhaobq_",
  "/bq/weixinbq_",
  "/bq/gaoxiaobq_",
  "/bq/shbq_",
  "/bq/dtbq_",
  "/bq/tiebabq_",
  "/bq/dmbq_",
  "/bq/liaotianbq_",
  "/bq/keaibq_",
  "/bq/weisuobq_",
  "/bq/wenzibq_",
  "/bq/maimbq_",
  "/bq/koubibq_",
  "/bq/tuxbq_",
  "/bq/tuzibq_",
  "/bq/gguaibq_",
  "/bq/shengqbq_",
  "/bq/jingdianbq_",
  "/bq/yuancbq_",
  "/bq/jieribq_",
  "/bq/zhufubq_"
]

# puts BqType.count
# puts Bq.limit(100).map &:attributes

BqType.destroy_all
Bq.destroy_all

PATHS.each do |path|
  mapping = {}

  begin
    first_url = "#{BASE}#{path}1#{SURFIX}"
    last_page = Nokogiri::HTML(open(first_url)).css('.tsp_end').attr('href')
    count = /\d+/.match(last_page)[0].to_i
    mapping[first_url] = count
  rescue Exception => e
    mapping[first_url] = 1
  end

  mapping.each do |url, page_count|
    puts '---'
    name = url.match(/bq\/(.+)bq_/)[1]
    bq_type = BqType.find_or_create_by name: name, url: url

    (1..page_count).each do |page|
      begin
        doc = Nokogiri::HTML(open(url.gsub(/(\d+)/, "#{page}")))
        doc.css('.liebiao_left .fo_link').each do |link|
          detail_page_link = link.attr('href')

          detail_doc = Nokogiri::HTML(open("#{BASE}#{detail_page_link}"))
          detail_doc.css('.m_xinmain img').each do |img|
            img_url = img.attr('src')
            image_url = img_url[/http/] ? img_url : "#{BASE}#{img_url}"
            bq_type.bqs.find_or_create_by origin_url: "#{img_url}"

            puts image_url
          end
        end
      rescue Exception => e
        puts e.backtrace
        puts '=' * 30
      end
    end
  end
end
