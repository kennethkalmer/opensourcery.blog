xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = "http://www.opensourcery.co.za/"
  xml.title "Open Sourcery"
  xml.subtitle "Performing regular wizardry through open-source software"
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.author { xml.name "Kenneth Kalmer" }

  # Filter out only the Clojure articles
  clojure = blog.articles.select { |article|
    tags = article.tags.map(&:downcase)
    tags.include?("clojure") || tags.include?("clojurescript")
  }.sort_by(&:date).reverse

  xml.updated(clojure.first.date.to_time.iso8601) unless clojure.empty?

  clojure[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)

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
