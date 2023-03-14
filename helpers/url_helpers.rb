require 'addressable'

module UrlHelpers
  def absolute_url(path)
    url = Addressable::URI.parse(root_url)
    url.path = path
    url.to_s
  end

  def encoded_url_for(path)
    encode_component(absolute_url(path))
  end

  def encode_component(s)
    Addressable::URI.encode_component(s, Addressable::URI::CharacterClasses::UNRESERVED)
  end

  def root_url
    config[:base_url]
  end

  def image_url(source)
    parts = [root_url, image_path(source)].compact
    URI.join(*parts)
  end
end
