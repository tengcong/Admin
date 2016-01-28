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

  field :article_page_content

  def crawl
    doc = Nokogiri::HTML(open(url))

    result = []

    doc.css(list_item_selector).each do |art|
      result << construct_article(art)
    end

    result
  end

  def construct_article art
    article = Article.new
    thumbnail_url = art.css(thumbnail_selector).attr('src')
    article.thumbnail = construct_url(thumbnail_url)
    article.title = art.css(title_selector).text
    article.description = art.css(description_selector).text
    article.published_at = art.css(published_at_selector).text
    page_url = art.css(detail_page_selector).attr('href')
    article.source = construct_url(page_url)
    article
  end

  def construct_url url
    uri = URI(self.url)

    if url[/http/]
      url
    else
      "#{uri.scheme}://#{uri.host}/#{url}"
    end
  end
end
