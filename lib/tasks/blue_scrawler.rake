require 'open-uri'

namespace :scrawler do
  base = "http://www.27270.com/"

  # http://www.du114.com/tags.html

  task create_photos: :environment do
    Album.where(tags: []).each do |album|
      doc = open_url(album.url)

      if doc

        begin
          total_count = doc.css('#pageinfo').attr('pageinfo').value.to_i
        rescue
          total_count = 1
        end

        tags = []
        doc.css('.photo-fbl a').each do |tag|
          tags << tag.attr('title')
        end

        album.tags = tags
        album.save

        (1..total_count).each do |page_num|
          if page_num == 1
            pic_path = album.url
          else
            pic_path = album.url.gsub('.html', "_#{page_num}.html")
          end

          doc = open_url(pic_path)

          if doc

            begin
              src = doc.css('#picBody img').attr('src').value
              album.photos.create url: src
            rescue
            end
          end
        end
      end
    end
  end

  task create_album: :environment do

    url = "#{base}tags.html"
    doc = open_url url
    doc.css('#Tag2 a').each do |elm|
      path = elm.attr('href')

      tag_url = "#{base}#{path}"

      begin
        last_page = open_url(tag_url).css('.TagPage li:last a').attr('href')
        total_count = /\d+_(\d+)/.match(last_page)[1].to_i
      rescue
        total_count = 1
      end

      (1..total_count).each do |page_num|
        if page_num == 1
          tag_url = "#{base}#{path}"
        else
          tag_url = "#{base}#{path.gsub('.html', "_#{page_num}.html")}"
        end

        puts tag_url

        open_url(tag_url).css("#imgList li").each do |item|

          album_url = item.css('a').attr('href').to_s
          album_title = item.css('a').attr('title').to_s
          album_thumbnail = item.css('a img').attr('src').to_s

          puts album_url
          puts album_title

          # ---- CREATE ALBUM ----
          puts Album.find_or_create_by title: album_title, url: album_url, thumbnail: album_thumbnail
        end
      end
    end
  end
end

def open_url url
  begin
    page = open(url).read
    page.force_encoding("gbk")
    page.encode!("utf-8")

    Nokogiri::HTML.parse page
  rescue
    nil
  end
end
