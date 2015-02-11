module FlattrHelper

  def flattr_article( article )
    url = [ "http://www.opensourcery.co.za", article.url ].join
    title = article.data["title"]
    lang = article.respond_to?(:lang) ? article.lang : "en-gb"

    options = {
      user_id: "kennethkalmer", url: url, title: title, language: lang
    }

    content_tag 'div', class: 'flattr-button' do
      link_to "https://flattr.com/submit/auto", query: options, title: "Flattr this!", target: "_blank" do
        image_tag "https://api.flattr.com/button/flattr-badge-large.png", alt: "Flattr this!"
      end
    end
  end

end
