---
id: 116
title: Easy Google/Yahoo! Sitemaps with webby
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=116
permalink: /2008/10/19/easy-googleyahoo-sitemaps-with-webby/
tags:
  - sitemap
  - webby
disqus_identifier: '116 http://www.opensourcery.co.za/?p=116'
---

<a href="http://webby.rubyforge.org" target="_blank">webby</a>, for those who don&#8217;t know, is a brilliant little gem by <a href="http://github.com/TwP" target="_blank">Time Pease</a> for creating and managing static HTML sites with Ruby. Built as extension to Rake, it allows you to manage your content seperately from your layout, and use a host of filters on your content (textile, haml, erb, etc).

I&#8217;ve been loving it so far, and have a host of ideas for extending webby (which will start in due time). We&#8217;ve been rebuilding the entire network of inX websites using all kinds of random combinations of Ruby. Between Merb, Rails and Webby we&#8217;ve got all our bases covered for the different websites.

**Sitemaps in webby**

Part of any site optimization experience is providing a sitemap for Google/Yahoo! indexing. This helps the search providers to better understand your content.

Creating a sitemap in Rails & Co is extremely simple, but how do you tackle it if webby?

Well, webby gives us access to a *@pages* instance variable, which is its own internal &#8220;resource database&#8221;. Note that I used the term *resource database* loosely. This allows us to run through all the pages in our site and extract some of their meta-data for use in a generated sitemap.

Create a file called *sitemap.xml* in the root of your content folder, and paste the following into it:

~~~
---
filter: erb
extension: xml
layout: nil
---
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <% @pages.find( :all, :sitemap => true ).each do |page| %>
    <url>
      <loc><%= page.url %></loc>
      <lastmod><%= page.mtime.strftime("%Y-%m-%d") %></lastmod>
      <% if page.changefreq %>
      <changefreq><%= page.changefreq %></changefreq>
      <% end %>
      <% if page.priority %>
      <priority><%= page.priority %></priority>
      <% end %>
    </url>
  <% end %>
</urlset>
~~~

The sitemap has its own meta, telling webby not to use a layout and keep the *xml* file extension. For the rest the file uses the *@pages* resource database to find pages that have been flagged for inclusion in the sitemap.

To add a file to the sitemap you extend the meta information of the page like this:

~~~yaml
---
sitemap: true
---
~~~

You can also provide a priority to the sitemap like this:

~~~yaml
---
sitemap: true
priority: 0.9
---
~~~

And even a change frequency:

~~~yaml
---
sitemap: true
priority: 0.9
changefeq: weekly
---
~~~

If you run a blog you can probably extend the idea for generating RSS or ATOM feeds.

**Robots.txt extension**

You also add a *robots.txt* file to the root of your content directory to help the crawlers find the sitemap, here is my copy:

~~~
---
filter: erb
extension: txt
layout:
---
Sitemap: /sitemap.xml
~~~

**Further reading**

  * <a href="http://webby.rubyforge.org" target="_blank">Webby homepage</a>
  * <a href="http://www.sitemaps.org/" target="_blank">sitemaps.org</a>
  * <a href="http://www.robotstxt.org/" target="_blank">robots.txt</a>
