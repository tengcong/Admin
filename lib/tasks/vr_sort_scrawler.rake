require 'nokogiri'
require 'open-uri'

namespace :vr_sort do
  task sites: :environment do
    base_url='http://vrsort.com/'
    doc = Nokogiri::HTML(open(base_url))
    categories = doc.css('.section')

    categories.each do |c|
      sc = SiteCategory.find_or_create_by(name: c.css('h3').text)
      types=c.css('dl')
      types.each do |t|
        st=SiteType.find_or_create_by(name: t.css('dt').text)
        sc.site_types << st

        t.css('dd > a').each do |a|
          site=Site.find_or_create_by(title: a.text, url: a.attr('href'))
          st.sites << site
        end
        st.save
      end
      sc.save
    end
  end
end