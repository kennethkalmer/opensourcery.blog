---
id: 38
title: 'Ruby and Messaging (Part 2) &#8211; Giving Rails a Break'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=38
permalink: /2008/11/07/ruby-and-messaging-part-2-giving-rails-a-break/
tags:
  - messaging
  - ruby
disqus_identifier: '38 http://www.opensourcery.co.za/?p=38'
---

<p class="info">
  <strong>NOTE:</strong> This post has been in draft for a couple of months now, and might seem a bit dated because of that. I need to complete the series and have decided to publish it for a sense of completeness.
</p>

Like all good bloggers out there, it seems plenty of days between episodes in a series is quite reasonable. Nevermind, thats just wrong. Anyone following this blog would have noticed the interesting rise and fall of [BIND DLZ on Rails][1], and its successor [PowerDNS on Rails][2]. This does seem to take a good chunk out of valuable writing time, especially when the likes of[ John Mettraux][3] are waiting for the next installments&#8230; So without further adue, here is *Ruby and Messaging (Part 2) &#8211; Giving Rails a Break*

**Introduction and ramblings**

Undoubtedly the topic of messaging in Rails has generated a lot of interest lately, and I&#8217;m sad that I missed my chance to be ahead of the curve in terms of coverage. Why is messaging such a hot topic? Well, Ruby (Rails and other frameworks) allows you to build extremely popular and powerful sites in record time. This does however bring some unforeseen problems, scaling being number one.

Oh no, not another scaling post! On the contrary, I&#8217;d like to highlight how developers hit stardom without ever realizing what it takes. The folks over at Google, Yahoo! and other popular properties had years to figure out how to build reliable, distributed and scalable systems. Amazon is one of the stars of the new Cloud Computing genre, with folks like EngineYard following hot on their tales. These cloud computing providers capitalize on the fact that everyday developers don&#8217;t know a thing about scaling systems. A timely post on the [Google Blog][4] proves this quite well:

> Back then, we did everything in batches: one workstation could compute the PageRank graph on 26 million pages in a couple of hours, and that set of pages would be used as Google&#8217;s index for a fixed period of time.

They processed 26 million records in a couple of hours on a *workstation*. I doubt that *workstation* compared to even a small AMI. See my point?

Now before we get to batches and distributed systems, lets take a step back and look at the simplest of Ruby messaging systems: the ones that help Rails &#8220;scale&#8221;. I&#8217;ll just be touching on them briefly, you&#8217;ll have to consult Google for more information and real examples.

**Giving Rails a break**

Now some purists might flame me for this, since it covers messaging at a conceptual level. The real implementations cannot be seen as pure messaging, but I believe in crawling before you walk (it&#8217;s just how nature intended).

So how why does Rails need a break? Some tasks just take too long. Bold, I know. &#8220;Too long&#8221; is extremely relative, considering Flickr keeps there page generation times well below 250 miliseconds. In that case, 300 milliseconds is a 20% increase in processing time! That, my dear reader, is taking &#8220;too long&#8221;.

I&#8217;ll be focusing the remainder of the post on methods that resemble messaging systems, not on ways to make Ruby any faster, or bypass expensive ActiveRecord operations. Other people have covered those topics already, and this is a build up to some more serious articles on messaging, not scaling.

**In process messaging**

I&#8217;ll be using the classical sending email is slow example, since its relevant to almost every single Rails application in existence.

Let me take a step back and define &#8220;in process messaging&#8221; as I see it. In process messaging is the act of sending an instruction from one part of a running application, to another. This may, or may not, involve the use of threading, but it remains inside a single process. This differs from inter-process (and mostly asynchronous) messaging, which involves message passing between different running systems.

Back to sending email. It&#8217;s slow because a mail server is a different beast all together. It takes more than 250 ms for a mail to get queued in a SMTP server, especially if the mail server is not on the same server as the Rails application. And besides, why can&#8217;t we run that &#8220;in the background&#8221; and tell the user the message has been sent? This means the user gets the confirmation page before Rails is even done with sending the message.

Using something like PHP would make this a snap. You&#8217;ll generate your confirmation message to the user, flush PHP&#8217;s buffers and ask Apache to close off the request. Then you&#8217;ll send the email afterwards, out of sight and out of mind. Rails doesn&#8217;t sport this option, but all is not lost.

Enter two plugins that caught my eye.

***Spawn***

Though it can run in fork mode (making it asynchronous), it does support threading mode (making it in process).

A simple code example looks like this:

~~~ruby
spawn do
  Mailer.deliver_registration_confirmation( @subscriber )
end
~~~

I&#8217;ve had the pleasure to use spawn on a couple of projects and it works very nicely. It&#8217;s especially rewarding to watch your log files and see the spawned process took a couple of seconds and you know that you didn&#8217;t keep the request on hold for that time.

You can also use spawn outside of Rails with minimal effort. Open up spwan.rb and have a look for yourself, it is a beautful little file that is very good at doing one thing.

***background***

The aptly named &#8220;[background][5]&#8221; plugin also does a great job of handling these long running tasks. I&#8217;ve used this one in an application or two and love it. It also covers various operation modes, but at its simplest it will also run in process.

~~~ruby
background do
  Mailer.deliver_registration_confirmation( @subscriber )
end
~~~

It&#8217;s as simple as that. It offers slightly more than spawn, but I&#8217;ll cover more advanced topics later in the series. It also supports out of process messaging, but thats covered next&#8230;

**Inter-process messaging**

Not to move on too quickly, but inter-process processing follows the same lines as the in-process examples. I&#8217;m using inter-process messaging loosely here to refer to Ruby-to-Ruby communication within the same project, and where you as the developer control both ends of the conversation.The later parts of the series will address different queuing implementations and protocols for performing tasks larger than just sending mail.

A player I really want to mention here is [BackgroundRB][6]. It steps things up a bit by running your workers outside of the Rails process. Jobs are queued & scheduled and handled by worker processes. It seems tightly coupled with Rails, so I don&#8217;t know how easy it would be to use it outside of Rails.

Using Distributed Ruby, or DRb, is another great way to have asynchronous processing. DRb is more of a roll-your-own solution, but really helps if you&#8217;ve planned properly and understand the DRb implementation. DRb uses its own format to pass messages around between servers. Did I just mention servers, and not client-server? *Yes*. In the DRb world the client is also a server and is asked to do processing the &#8220;server&#8221; can&#8217;t. This has bitten me on the arse before, and thats why I said you need proper planning. If you pass complicated objects over the wire, the processing will be directed back to the client, effectively rendering DRb useless. I&#8217;ll cover this at some other time.

Another approach I&#8217;ve used where the communication needs to be synchronous, but between different processes is to build my own REST services. I&#8217;ve favored [Halcyon][7] so far, for no other reason than getting familiar with JSON. You can use your imagination when you control both ends of the conversation, but keep your messages in a format thats preferably standard and open, like XML/JSON.

**Synchronous and asynchronous processing**

Just to avoid confusion I need to make this clear. No matter how your messages travel, be it in-process or inter-process, it doesn&#8217;t make it asynchronous. My examples of using the spawn and background allow for *asynchronous processing* using variables as in-process messages (or instructions). Furthermore the REST API example does the opposite, it uses inter-process messaging as part of a *synchronous process*.

Keep the distinction clear in your design. Messaging is a form of communication and not of processing. Various people use the terms almost interchangeably and this makes it seemingly difficult to grasp the concepts correctly.

Using a clear, concise and open messaging implementation will build you applications that can grow almost indefinitely. Look at the web as a prime example of this, with billions simple HTTP messages getting passed around every couple of minutes.

**Looking forward**

There are definitely better approaches available to us, including message queuing, broadcasting and message federation, to name but a few. The next parts of the series will cover these topics in more details. Looking back at [the first part of the series][8] I made a proposition that we model our systems after existing ecosystems found in nature. In such a ecosystem each component can live on it&#8217;s own, evolve separate and flourish.

The topics discussed in the post doesn&#8217;t really encourage the building of an ecosystem, but rather an abomination if used incorrectly. Its from my own experiences of dealing with these abominations that I&#8217;ve modeled my ecosystems on nature and continue to see them flourish. These approaches are also tied to Rails, with the exception of DRb and REST, and create a lock-in of sorts. Not that I don&#8217;t like Rails, I love having options even more.

The next two articles will focus on using Jabber/XMPP and AMQP, and all their friends. Two very powerful technologies that compete head on for developer mindshare, although I sometimes believe the mindshare should be 50/50. After that I might change the direction to practical uses and implementations of messaging ([ruote][9] comes to mind).

<p class="info">
  <strong>NOTE:</strong> This post has been in draft for a couple of months now, and might seem a bit dated because of that. I need to complete the series and have decided to publish it for a sense of completeness.
</p>

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails/
 [2]: https://github.com/kennethkalmer/powerdns-on-rails/
 [3]: http://jmettraux.wordpress.com/
 [4]: http://googleblog.blogspot.com/2008/07/we-knew-web-was-big.html
 [5]: http://devblog.imedo.de/2008/6/18/running-ruby-blocks-in-the-background
 [6]: http://backgroundrb.rubyforge.org/
 [7]: http://halcyon.rubyforge.org/
 [8]: /2008/07/07/messaging-and-ruby-part-1-the-big-picture/
 [9]: http://openwferu.rubyforge.org/
