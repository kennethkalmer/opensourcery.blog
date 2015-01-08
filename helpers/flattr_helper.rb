module FlattrHelper

  def flattr_article( article )
    url = [ "http://www.opensourcery.co.za", article.url ].join

    options = {
      user_id: "kennethkalmer", url: url, title: article.title, language: article.lang
    }

    content_tag 'div', class: 'flattr-button' do
      link_to "https://flattr.com/submit/auto", query: options, title: "Flattr this!", target: "_blank" do
        image_tag "https://api.flattr.com/button/flattr-badge-large.png", alt: "Flattr this!"
      end
    end
  end

end
