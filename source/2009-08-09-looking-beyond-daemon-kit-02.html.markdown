---
id: 234
title: Looking beyond daemon-kit 0.2
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=234
permalink: /2009/08/09/looking-beyond-daemon-kit-02/
tags:
  - daemon-kit
disqus_identifier: '234 http://www.opensourcery.co.za/?p=234'
---

![Works Ahead - Singapore Department of Transport](2009-08-09-looking-beyond-daemon-kit-02/works-ahead.jpg)

I wrote [daemon-kit][1] to solve two big issues with writing daemon processes in Ruby:

  1. Everyone is re-inventing the [daemons gem][2]
  2. Individual daemons share a lot common code, apart from the daemonizing bits

As for #1, daemon-kit at first wrapped the daemons gem, and later ripped it out completely as it was difficult to wrap up the worst of the daemons gem properly.

\#2 seemed to be a twofold problem that daemon-kit has also addressed with great success. The first was addressing the all too common issues of logging, pid file management, umasks, signal traps, config files, exception handling and other &#8220;low-level&#8221; issues. Everyone was implementing these things to a limited extent in their daemons and this could cause a lot of frustration when done wrong. The second part was the need, even if undiscovered, for higher level re-use and development speed. Daemon-kit addresses this with some limited generators, making it easy to get going with a cron-style daemon, AMQP & XMPP bots as well as the newest addition, Ruote remote participants.

All this is fine and well, and people seem to like the project. The mailing list is getting some noise, we&#8217;re over [200 watchers strong][3] on Github and the IRC channel has some folks popping in to say hi.

However, daemon-kit quickly made me lazy and realize there is a couple of things it can do much better. If you&#8217;ve used a generator before, you&#8217;ll notice the generated code is very much stuck to that type of daemon. Changing from XMPP to AMQP (for illustrative purposes) would be best accomplished by generating a new project and copying over the *lib/* folder only. This sucks.

Another problem is people, myself included, would like to have [Sinatra-style daemons][4] (i.e. one file) for smaller tasks. Currently this is not possible at all. Another thing I know people are doing behind my back is generating daemons inside Rails projects, which may or may not work, depending on whether you load Rails&#8217; environment.rb.

**So, what happens now?**

My thoughts are to implement privilege dropping support and tag a 0.2 release. This gives us a feature complete framework, albeit not as good as it can be. I&#8217;ll maintain 0.2 as a stable while undertaking the rewrite. A rewrite? Read on.

I [posted to the daemon-kit list][5] a suggestion for stackable daemon environments. I&#8217;ve discussed this in IRC with a few folks as well. [Jordan Ritter][6] gave me an exceptional breakdown of the dangers of doing something because it is &#8220;neat&#8221; and I&#8217;ve taken his warning to heart. However, I cannot seem to argue against stackable daemon environments, it sounds too good.

The idea is pretty simple. Stack-entries can be compared to Rack applications, with two significant differences. The first is that they will be *called only once*. They have the opportunity to change the environment in which the final code runs. The second is that they can be called at four different stages of the daemon lifecycle: argument processing, pre-daemonization, post-daemonization and shutdown. This differs from Rack&#8217;s single *call()* method.

The stackable nature also gives the stack members easier ways to set conventions and can dramatically minimize configuration. It paves the way for plugins, sinatra-style daemons, rails-based daemons and easier packaging of distributable daemons, and so much more. Looking at the internals of daemon-kit, it would greatly help simplify the existing code as well as help separate utility classes from stack members.

The more I think about it, the more obvious this becomes, and the more possibilities unfold for the framework. This will definitely make daemon-kit a force to be reckoned with, and hopefully I can persuade other library developers to offload their daemonizing code to daemon-kit, just like rack developers offload their HTTP handling to rack.

 [1]: http://github.com/kennethkalmer/daemon-kit
 [2]: http://daemons.rubyforge.org/
 [3]: http://github.com/kennethkalmer/daemon-kit/watchers
 [4]: http://groups.google.com/group/eventmachine/msg/84372822d1cb06db
 [5]: http://groups.google.com/group/daemon-kit/browse_thread/thread/6d8be608798f67e6
 [6]: http://github.com/jpr5
