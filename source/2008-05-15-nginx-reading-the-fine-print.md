---
id: 24
title: 'nginx &#8211; Reading the fine print'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=24
permalink: /2008/05/15/nginx-reading-the-fine-print/
tags:
  - nginx
  - rails
disqus_identifier: '24 http://www.opensourcery.co.za/?p=24'
---

Surely your Rails app flies, no request takes longer than 60 seconds to complete, ever. You&#8217;ve proven that Rails can scale and all that jazz. Surely you&#8217;ve really spent the time to read the [nginx wiki][1] and customize [Ezra&#8217;s nginx.conf][2] to such a degree that you can handle thousands of concurrent requests at any given time. You know, Rails scales&#8230;

Now some of us develop fairly intricate systems using Rails. Systems that have long running reports, or systems that connect to other systems to execute commands, or obtain information. Whatever the reason, somethings just can&#8217;t complete within 60 seconds, and if your users understands the complexity of the background tasks they&#8217;ll quite happily press a button and go make coffee while the server crunches away at the reports.

I head one such project, and had the most interesting issue I just solved. And it involved reading a lot on nginx&#8217;s fine print&#8230;

Meet [proxy\_next\_upstream][3], an nginx directive that is very very useful, but a pain in the ass at the same time. Remember the opening example of creating a large report from loads of data? This can easily take longer than 60 seconds to complete. Lets analyze what happens in this case:

nginx sends the request to any one of the mongrels specified in upstream. It will wait for the mongrel to complete and return a response that will be sent back to the client. However, it will not wait forever, it will wait for [proxy\_read\_timeout][4] which defaults to 60 seconds. What happens after 60 seconds. You might be inclined to think that the timeout will be communicated to the client in the form of a nginx error&#8230; I did. It appears not.

By default, *proxy\_next\_upstream* is set to &#8220;*error timeout*&#8220;. Reading the fine print reveals that nginx would retry the request to the next available upstream proxy (a.k.a mongrel), causing it to just lockup again with a fresh request for a new report. This will continue until all your upstream mongrels are busy generating the same massive report before nginx gives up.

This isn&#8217;t nginx&#8217;s fault, on the contrary I think its an awesome feature. Especially if you reflect back on that massively scalable Rails application you&#8217;re building. You can have nginx retry on a 500, 503 or 404 amongst others. So some errors can be hidden from the client, especially if a replication slave goes down briefly or has some lag from the masters and causes a 404 inside an action. Even if monit is busy taking down those resource hungry dogs, you can have nginx retry on behalf of the client without them noticing.

Be cautious, this isn&#8217;t exactly the kind of thing you can test in a function/integration test. And never tamper with your production nginx configurations without gunning it on your staging servers first.

 [1]: http://wiki.codemonger.com
 [2]: http://brainspl.at/articles/2007/01/03/new-nginx-conf-with-optimizations
 [3]: http://wiki.codemongers.com/NginxHttpProxyModule#proxy_next_upstream
 [4]: http://wiki.codemongers.com/NginxHttpProxyModule#proxy_read_timeout
