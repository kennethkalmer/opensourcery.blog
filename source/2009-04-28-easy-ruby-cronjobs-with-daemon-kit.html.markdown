---
id: 183
title: Easy Ruby cronjobs with daemon-kit
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=183
permalink: /2009/04/28/easy-ruby-cronjobs-with-daemon-kit/
tags:
  - cron
  - daemon-kit
  - projects
disqus_identifier: '183 http://www.opensourcery.co.za/?p=183'
---

I started conceptualizing and playing with a pet project called [daemon-kit][1] earlier this year, with the aim to ultimately be the preferred way of assembling daemon processes written in Ruby.

Today I took the opportunity to add two more generators to daemon-kit, as well as fix some small annoying issues. The first generator is a &#8216;cron&#8217; generator, which I&#8217;ll cover in this article. The second is an AMQP consumer, that my day job requires.

Running cron-style daemon processes seems to be a common need in the Ruby world, and my first ever daemon process was a cron-style implementation using the remarkable [rufus-scheduler][2] gem by [John Mettraux][3]. The second, an SQS client. Writing Ruby daemon processes is quick and simple, but getting to know the ins and outs of these hidden beasts can be quit a nightmare.

As of late I&#8217;ve been threatening in #ruote that daemon-kit will sport a &#8216;cron&#8217; style generator when I get the time. Today I made time, and you can now get a simple cron daemon up and running in minutes, heres how:

**1. Get daemon-kit & co**

~~~
$ sudo gem install kennethkalmer-daemon-kit
$ sudo gem install rufus-scheduler
~~~

rufus-scheduler is not a direct dependency of daemon-kit, but required by the daemons generated using the cron generator.

**2. Generate a stub daemon**

~~~
$ daemon_kit mycrond -i cron
~~~

This creates a project layout in a directory named &#8216;*mycrond*&#8216;. You can populate the *lib* folder with your custom code. What matters though is that your generated &#8216;cron&#8217; daemon lives in *libexec/mycrond.rb*.

**3. Profit**

Open up *libexec/mycrond.rb* to reveal a fully functional cron-style daemon, complete with sample 1 minute task.

**Behind the scenes**

All of daemon-kit is basically two things: abstracting daemonizing routines and environment configurations, and wrapping supporting libraries in thin wrapper classes for easing their use inside daemon processes. The cron wrapper class is extremely thin, in part due to the excellent implementation of the rufus-scheduler gem.

As with all projects, I cannot imagine every possible use for the gem and rely on feedback from the community. If you are going to attempt using ActiveRecord inside the cron daemon, beware that you might have to juggle some balls with ActiveRecord and threads. Please report these issues on [the github tracker][4] and I&#8217;ll attempt to find solutions for you. I highly recommend using ActiveRecord 2.3.2 or later to benefit from the connection pooling and thread safety improvements.

 [1]: http://github.com/kennethkalmer/daemon-kit
 [2]: http://github.com/jmettraux/rufus-scheduler
 [3]: http://jmettraux.wordpress.com/
 [4]: http://github.com/kennethkalmer/daemon-kit/issues
