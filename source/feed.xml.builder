xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "Open Sourcery"
  xml.subtitle "Performing regular wizardry through open-source software"
  xml.id absolute_url(blog.options.prefix)
  xml.link "href" => absolute_url(blog.options.prefix)
  xml.link "href" => absolute_url(current_page.path), "rel" => "self"
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name "Kenneth Kalmer" }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => absolute_url(article.url)
      xml.id absolute_url(article.url)

      # For the older articles
      if article.data[:guid]
        xml.guid article.data[:guid], isPermalink: false
      end

      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name article.data[:author] }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
