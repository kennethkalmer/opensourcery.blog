---
id: 296
title: Practicing safe Ruby, with safely
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=296
permalink: /2011/04/14/practicing-safe-ruby-with-safely/
tags:
  - daemon-kit
  - projects
  - ruby
disqus_identifier: '296 http://www.opensourcery.co.za/?p=296'
---

One of the things that makes [daemon-kit][1] such a great project (at least to me), is the built-in &#8220;safely&#8221; method wraps your code in a loving embrace of error reporting comfort. You could at any point do this:

~~~ruby
safely do
  something_dangerous!
end
~~~

and your daemon would not die if something blew up. Instead the daemon would happily log the error to file (and possibly Hoptoad) and carry on working.

As part of resurrecting daemon-kit, I&#8217;ve extracted this functionality into a new gem called &#8220;[safely][2]&#8220;, available now on Github and Rubygems. At the moment it just supports [Hoptoad][3] via the [Toadhopper][4] gem, but soon will offer more!

I&#8217;ll expand on it in the coming days, and then tend to the daemon-kit fork queue while replacing the daemon-kit version with safely.

 [1]: https://github.com/kennethkalmer/daemon-kit
 [2]: http://github.com/kennethkalmer/safely
 [3]: http://www.hoptoadapp.com/
 [4]: http://github.com/toolmantim/toadhopper
