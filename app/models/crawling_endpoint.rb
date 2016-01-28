class CrawlingEndpoint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url

  field :list_item_selector
  field :thumbnail_selector
  field :title_selector
  field :description_selector
  field :published_at_selector
  field :detail_page_selector


  def crawl
    doc = Nokogiri::HTML(open(url))

    result = []

    doc.css(list_item_selector).each do |art|
      article = Article.new

      thumbnail_url = art.css(thumbnail_selector).attr('src')

      article.thumbnail = thumbnail_url[/http/] ? \
        thumbnail_url : url + thumbnail_url

      article.title = art.css(title_selector).text
      article.description = art.css(description_selector).text
      article.published_at = art.css(published_at_selector).text

      page_url = art.css(detail_page_selector).attr('href')

      article.detail_page_url = page_url[/http/] ? \
        page_url : url + page_url

      result << article
    end

    result
  end

end
