require 'nokogiri'
require 'open-uri'

namespace :hiapk do
  base ='http://pic.hiapk.com/jc/GIF/'

  task do_scrawl: :environment do
    doc = Nokogiri::HTML(open(base))
    doc.css('#container > li > a').each do |link|

      name = link.css('span').text.chop
      tags = ['内涵', '爆笑']

      bqPackage = BqPackage.find_or_create_by name: name, tags: tags

      url =link.attr('href')
      doc1 = Nokogiri::HTML(open(url))

      doc1.css('.small_list.mt20 img').each do |img|
        bqPackage.bqs.create origin_url: img.attr('data-bigimg')
      end
    end
  end
end




