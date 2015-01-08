---
id: 210
title: daemon-kit Progress Report
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=210
permalink: /2009/06/11/daemon-kit-progress-report/
tags:
  - daemon-kit
  - projects
disqus_identifier: '210 http://www.opensourcery.co.za/?p=210'
---

Since I last [announced Capistrano support][1] for daemon-kit, a few other things have happened that is steadily moving the project forward. Here is a synopsis of them all:

**No more daemons**

Sounds contradictory, but I&#8217;ve stripped out the daemons gem as a depedency. Everything the daemons gem offered is now handled inhouse, and works much better. For more information please read the [release announcement][2].

**Better command line argument handling**

A lot has been done to smooth out command line argument handling, and daemons can now tap into the command line processing very easily. Details in the [release announcement][2] and the [RDoc][3].

**Error mails now handled by TMail**

Makes them look better and be better formed, the initial code didn&#8217;t really produce meaningful mails. A lot of work still needs to be done in this arena.

**Log with vigor!**

Logging got a lot of attention with the [new AbstractLogger interface][4]. Log rotation is now dead simple and logging to Syslog is possible thanks to the SysLogLogger gem. See the [RDoc][5] for more information on logging.

**Cucumber**

Still a lot needs to be done to simplify testing daemon processes, but the inclusion of [preliminary cucumber support][6] is one step in the right direction. I&#8217;m hoping cucumber will be a great fit for daemon-kit, and help us as daemon developers define the difficult contexts in which our code runs.

*Looking forward*

Plenty still needs to be done, the `TODO` file in the repo is some insight into what the future holds. Mostly daemon-kit evolves as I need it to for my production environments. On Github we&#8217;re close to 200 watchers, and the Google Group does have a little activity.

As time goes on I&#8217;m hoping more people get involved and bring suggestions to the table for the framework. So please, do tell me how daemon-kit can make your life simpler for your, and your daemons.

 [1]: /2009/05/26/capistrano-for-your-daemons/
 [2]: http://groups.google.com/group/daemon-kit/browse_thread/thread/06f4adc6fbf2f030#
 [3]: http://kit.rubyforge.org/daemon-kit/rdoc/Configuration_txt.html
 [4]: http://groups.google.com/group/daemon-kit/browse_thread/thread/3a7bb8af7bf3d471#
 [5]: http://kit.rubyforge.org/daemon-kit/rdoc/Logging_txt.html
 [6]: http://groups.google.com/group/daemon-kit/browse_thread/thread/74426229f89dc325#
