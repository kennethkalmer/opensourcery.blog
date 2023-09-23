###
# Blog settings
###

Time.zone = "Europe/London"

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false
page "/clojure.xml", layout: false

# .htaccess love
page "/.htaccess.html", layout: false

# https://github.com/middleman/middleman/issues/1243#issuecomment-39356604
config.ignored_sitemap_matchers[:source_dotfiles] = proc { |file|
  path = file.full_path.to_s
  path =~ %r{/\.} && path !~ %r{/\.(well-known|htaccess|htpasswd|nojekyll)}
}

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Nice URL's
activate :directory_indexes

# Disqus
activate :disqus do |d|
  # Disqus shotname, without '.disqus.com' on the end (default = nil)
  d.shortname = 'opensourcery'
end

# UA
# activate :google_analytics do |ga|
#   ga.tracking_id = 'UA-192703-9'
# end

# Syntax
activate :syntax

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Static assets
activate :external_pipeline,
         name: :gulp,
         command: "./node_modules/.bin/gulp #{'build' if build?}",
         source: "tmp"

# Markdown tweaks
set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true, :fenced_code_blocks => true

set :js_dir, "javascripts"
set :css_dir, "stylesheets"
set :images_dir, "images"
set :fonts_dir, "fonts"

configure :development do
  set :base_url, "http://localhost:4567"
  set :url_root, config[:base_url] # Sitemap only
end

# Build-specific configuration
configure :build do
  set :base_url, "https://opensourcery.blog"
  set :url_root, config[:base_url] # Sitemap only

  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

# Be discoverable
activate :search_engine_sitemap
