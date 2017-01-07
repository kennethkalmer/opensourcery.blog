---
id: 213
title: Cleaning up your act, with a little handsoap
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=213
permalink: /2009/06/12/cleaning-up-your-act-with-a-little-handsoap/
tags:
  - postini
  - ruby
  - soap
disqus_identifier: '213 http://www.opensourcery.co.za/?p=213'
---
![Dettol Handsoap](2009-06-12-cleaning-up-your-act-with-a-little-handsoap/dettol-1.jpg)

[Handsoap][1] is a new, fresh Ruby library for creating[ SOAP][2] clients. Why am I excited about soap? [I&#8217;m not][3], unless they&#8217;re [beautiful][4]. Yet, somewhere along the line you are going to be faced with writing a client for a SOAP service. Whether it is from your suppliers (4 different crap API&#8217;s in my case), or just for mashing up data from a rest-less source.

Ruby has very little to offer in terms of SOAP, afaik it only had [soap4r][5] until handsoap came along&#8230;

*BIG DISCLAIMER: This is not a flame war against soap4r, it&#8217;s against SOAP.*

The authors and contributors have spent a lot of time and effort over the years to build soap4r up to where it is currently. It is a remarkable piece of work, but the cracks are showing. I&#8217;ve spent countless hours digging through the code trying to figure out why my mappings and registeries aren&#8217;t working as expected. You find code working around bugs in Ruby 1.8.2 and 1.8.4, and we&#8217;re all trying to move to 1.9. That is a lot of skeletons to hide&#8230;

It&#8217;s not all doom for soap4r, I&#8217;ve used it to play around with some public API&#8217;s for weather and currency data, and if the API is well defined and leverages SOAP as a protocol, soap4r really rocks. The results of wsdl2ruby is bit tricky to navigate, but mostly you can leave that alone and focus on your code.

But, and there always has to be a but&#8230;

A lot of API&#8217;s are written by people who have no idea what it is like to be on the consuming side of their mess. This is where soap4r falls flat on its face. Take the case of [Postini][6] and the [postini][7] gem for instance. The gem was my first gem ever and as far as I&#8217;m considered it was my worst code ever (open source at least). It was an absolute mess, barely worked more than what our systems required, and was not expandable in any way. The root of the problem was not soap4r, but the worst combination of WSDL and PDF docs to land on any developers screen. The documentation and the WSDL don&#8217;t match, not by a long shot, and you have to debug minor issues with wiredumps. I&#8217;ll stop my rant now.

**Enter handsoap**

As development of [our][8] [premier product][9] comes closer to launch, our email systems came under scrutiny and I needed to update the way we interact with Postini through our gem. I couldn&#8217;t, I could barely figure out what I did in the first place. If there was any proper use of the gem outside our company, I would have probably been summoned to criminal court for the injustice I had done in the first release.

So I started over, and I learned about handsoap a couple of weeks ago already.

This was the result in 24 hours:

~~~
$ git log --stat 2f91d4d6eaa8bd76c188f20929a19e456d1bb52e..HEAD | grep changed
 2 files changed, 15 insertions(+), 4 deletions(-)
 1 files changed, 38 insertions(+), 0 deletions(-)
 2 files changed, 282 insertions(+), 1 deletions(-)
 1 files changed, 1 insertions(+), 1 deletions(-)
 12 files changed, 9 insertions(+), 682 deletions(-)
 1 files changed, 1 insertions(+), 0 deletions(-)
 8 files changed, 184 insertions(+), 3883 deletions(-)
 6 files changed, 154 insertions(+), 18 deletions(-)
~~~

That is over 4000 lines of code, gone! Talk about [beauty soap][10]&#8230;

At the moment the library is a super thin layer on top of the raw API, but it works surprisingly well and easier to comprehend.

Handsoap&#8217;s beauty comes that it leaves you to do all the parsing and prepping of the SOAP requests/responses. At first this sounds daunting, but as you start using it the benefits become very clear and you are in full control of your client. The author published a [video tutorial][11] which shows how to build a weather server client in Rails. It is a very fast paced video, but download a copy and step through it piece by piece.

Handsoap does an excellent job at bringing together [curb][12] as the HTTP client, and [Nokogiri][13] for the XML parsing. It delivers, blazingly fast.

**Code Teaser**

The [EndpointResolverService][14] in the postini gem is a nice example of a single method service that is used to return another endpoint for subsequent API calls.

At the very least you need a skeleton class that looks something like this:

~~~ruby
EXAMPLE_SERVICE_ENDPOINT = {
  :uri => 'http://example.org/ws/service',
  :version => 2
}

class SomeService < Handsoap::Service
  endpoint EXAMPLE_SERVICE_ENDPOINT
  on_create_document do |doc|
    doc.alias 'end', 'https://api-meta.postini.com/api2/endpointresolver'
  end
end
~~~

After that, you&#8217;re pretty much on your own (which turns out to be great).  Troels shows in the video tutorial how to use a clever Java application called [soapUI][15] to analyze the WSDL and prepare your request markup and response parsing accordingly. It works like I charm.

I have three other internal soap4r-based gems that work on the worst API&#8217;s you&#8217;ve seen in your life (can you say nusoap?). One of them even lacks a WSDL, and returns serialized PHP data. They were a nightmare to consume, and I&#8217;m looking forward to cleaning them up with handsoap as well.

I&#8217;m hoping this blog post serves as a motivator for you to clean up your (SOAP) act too. I&#8217;ve got two more posts lined up on handsoap, one about mocking your way through writing a SOAP client, and another on using soapUI&#8217;s mock service capabilities.

Until then, please share in the comments your worst Ruby SOAP stories (and go easy on soap4r, it&#8217;s not their fault).

 [1]: http://github.com/troelskn/handsoap
 [2]: http://en.wikipedia.org/wiki/SOAP
 [3]: http://twitter.com/kennethkalmer/status/1096642892
 [4]: http://twitter.com/kennethkalmer/status/1307995769
 [5]: http://dev.ctor.org/doc/soap4r/
 [6]: http://www.postini.com/
 [7]: http://github.com/kennethkalmer/postini4r-postini
 [8]: http://www.inx.co.za
 [9]: http://www.ispinabox.co.za/
 [10]: http://www.flickr.com/photos/jmettraux/3162884472/
 [11]: http://www.vimeo.com/4813848
 [12]: http://curb.rubyforge.org
 [13]: http://nokogiri.rubyforge.org
 [14]: http://github.com/kennethkalmer/postini4r-postini/blob/2dfced395e2ac7c479232e96b9a372046ff33329/lib/postini/endpoint_resolver_service.rb
 [15]: http://www.soapui.org/
