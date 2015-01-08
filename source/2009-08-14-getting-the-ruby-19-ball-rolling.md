---
id: 243
title: Getting the Ruby 1.9 ball rolling
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=243
permalink: /2009/08/14/getting-the-ruby-19-ball-rolling/
tags:
  - ruby19
disqus_identifier: '243 http://www.opensourcery.co.za/?p=243'
---

<blockquote class="twitter-tweet" lang="en"><p>Labnotes » I switched to Ruby 1.9 (and you should too) http://bit.ly/ue1XI</p>&mdash; Ruby Update (@rupdate) <a href="https://twitter.com/rupdate/status/3306126571">August 14, 2009</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

After I read [this post][2] on Labnotes I decided to &#8220;take the plunge&#8221; into the world of Ruby 1.9 properly. I mean, I was at RubyKaigi where the biggest lesson of all was &#8220;Change!&#8221; (and changing to 1.9). Ruby 1.9.1 has been stable for quite some time now, and 1.9.2 is due out on Christmas. And we&#8217;re still stuck on 1.8.6 ? **WTF**

Getting started with Ruby 1.9 is easy (only time will tell [how much pain][3] is caused). I have to admit I&#8217;m not as brave to wipe my rubygems installation, I might still need 1.8.6 (and I seriously hope I don&#8217;t).

So Relevance made this awesome bash script called [ruby_switcher.sh][4] that you absolutely have to try. Once you have it installed and working as per their instructions you need to make one small change to the very last line of ruby_switcher.sh. That change looks like this:

~~~
#use_leopard_ruby
use_ruby_191
~~~

Simple and I can easily toggle 1.8.6 mode if needed.

<blockquote class="twitter-tweet" lang="en"><p>defaulted to Ruby 1.9 on my mac, now to work through my <a href="https://twitter.com/github">@github</a> projects and get them passing</p>&mdash; Kenneth Kalmer (@kennethkalmer) <a href="https://twitter.com/kennethkalmer/status/3307027729">August 14, 2009</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Yes, I did.

So over the coming days I&#8217;ll be working through all 28 of my github repos and making sure they run on 1.9. This is no small task, but I&#8217;m looking forward to getting my &#8220;house&#8221; in order.

At this stage I know [acts\_as\_audited][6] is 1.9 compatible, I fixed it earlier the week while testing ruby_switcher. I had a look at [ActiveRecord::Tableless][7] and decided to pull the plug on the project completely ([see here][8]).

I&#8217;m really looking forward to this adventure and sharing the ups and downs of the road with everyone. Ultimately I would love it if we can get the South Africa Ruby ecosystem on 1.9.X ASAP.

 [1]: http://twictur.es/i/3306126571.gif
 [2]: http://blog.labnotes.org/2009/08/13/i-switched-to-ruby-1-9-and-you-should-too/
 [3]: http://twitter.com/vandermerwe/status/3307761128
 [4]: http://blog.thinkrelevance.com/2009/7/29/ruby-switcher-working-with-multiple-ruby-versions-has-never-been-this-easy
 [5]: http://twictur.es/i/3307027729.gif
 [6]: http://github.com/kennethkalmer/acts_as_audited
 [7]: http://github.com/kennethkalmer/activerecord-tableless-models
 [8]: http://github.com/kennethkalmer/activerecord-tableless-models/commit/097ad7f5f2d5589beb867790873df04f25c5b842
