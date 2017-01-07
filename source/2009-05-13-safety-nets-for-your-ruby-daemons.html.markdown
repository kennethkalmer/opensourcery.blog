---
id: 201
title: Safety nets for your Ruby daemons
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=201
permalink: /2009/05/13/safety-nets-for-your-ruby-daemons/
tags:
  - daemon-kit
  - hoptoad
  - projects
disqus_identifier: '201 http://www.opensourcery.co.za/?p=201'
---

[Daemon-kit][1] has been getting a lot of TLC from me lately, and it&#8217;s not going to stop anytime soon. As I wander deeper and deeper into AMQP territory, I need to extend daemon-kit to cope with all kinds of new scenarios. One of those being unhandled exceptions.

The second thing I put on the TODO list was Rails-style exception handling. With version 0.1.6 there has been some progress made in that regard. Daemon-kit now sports a configurable safety net for dangerous code. By wrapping blocks of code in a &#8220;safety net&#8221;, unhandled exceptions are caught and logged, and optionally sent via email or to [Hoptoad][2] for review.

Hoptoad? In a Ruby daemon? Sure, inspiration came via these tweets.

<blockquote class="twitter-tweet" lang="en"><p>We added hoptoad to our custom ruby daemon... Already finding lots of errors, hoptoad is great for visibility into a daemon.</p>&mdash; Josh Owens (@joshowens) <a href="https://twitter.com/joshowens/status/1727857995">May 7, 2009</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="en"><p>Integrated Hoptoad into a regular ruby daemon process.</p>&mdash; Andy Shen (@shenie) <a href="https://twitter.com/shenie/status/1725958950">May 7, 2009</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

And it only makes sense to do it. Now for some code:

~~~ruby
safely do
  # do something silly
  silly.action!
end
~~~

*safely* is mixed into *Object* and can be used freely. It is important to note that you have to handle your daemon-specific applications on your own and rely on *safely* as a fall over mechanism.

To configure the safety net, you can edit your *config/environment.rb* file and add the following lines to the configure block:

~~~ruby
# for email notifications
config.safety_net.handler = :mail
config.safety_net.mail.recipients = ['you@gmail.com']

# for hoptoad
config.safety_net.handler = :hoptoad
config.safety_net.hoptoad.api_key = 'your-hoptoad-key'
~~~

The documentation is very rough at the moment, but the files you want to explore are *lib/daemon_kit/safety.rb* and the error handlers in *lib/daemon\_kit/error\_handlers*.

**NOTE:** If you are upgrading from an earlier daemon-kit, please upgrade your daemons as well by running the following rake task in the root of your daemon projects:

`$ rake daemon_kit:upgrade`

In the coming days/weeks you can look forward to the following enhancements as well:

  * Improved logging
  * Improved backtrace cleanups
  * Improved rdoc&#8217;s
  * [rack][5] application generator (with [rack-mount][6])

I&#8217;m patching things up as I go along, adding features as I need them (and stuff I recall from my first daemons). There is still a lot of things that need attention, but they&#8217;ll be addressed and hopefully daemon-kit grows to becoming the premier framework for writing daemon processes in our beloved Ruby.

 [1]: http://github.com/kennethkalmer/daemon-kit
 [2]: http://hoptoadapp.com/
 [5]: http://rack.rubyforge.org/
 [6]: http://github.com/josh/rack-mount
