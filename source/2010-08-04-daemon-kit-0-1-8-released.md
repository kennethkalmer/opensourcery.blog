---
id: 292
title: daemon-kit 0.1.8 released
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=292
permalink: /2010/08/04/daemon-kit-0-1-8-released/
tags:
  - daemon-kit
disqus_identifier: '292 http://www.opensourcery.co.za/?p=292'
---

I&#8217;m proud to announce that daemon-kit has finally made it to 0.1.8.1, almost a year after the last patch release. There has been a lot of changes since the last release, mostly cleanly up and staying with the times (so to speak). Github has an awesome compare view, <a href="http://github.com/kennethkalmer/daemon-kit/compare/0.1.7.12...0.1.8" target="_blank">detailing the historic moment</a>, and I&#8217;ll go through it here in some detail as well.

First off I&#8217;d like to thank a few people who have quietly and vocally contributed to or promoted daemon-kit. In no particular order, thanks goes to:

  * [Josh Owens][1] ([@joshowens][2]) for actively testing bug fixes and promoting the project
  * [Mike Perham][3] ([@mperham][4]) for actively reporting bugs, providing patches and promoting the project
  * I&#8217;ve pulled in patches from the forks of [Michael Hutchinson][5], [Milan Novota][6], [Joey Geiger][7], and [John Merrels][8]
  * [Greg Campbell][9] reported an issue with the AMQP generated daemons only hours after pushing 0.1.8 to gemcutter

The two biggest changes for me has been converting all the generators to use Thor, and using Bundler in the generated daemons. Both of these projects have received some flack, but they both continue to serve me very well and I&#8217;m sure they&#8217;ll serve daemon-kit well.

The logger got some minor updates, to be more compatible with the standard Ruby logger class. A brand new XMPP generator is included, and it uses Blather for some awesome evented-goodness. Argument handling got fixed up, email exceptions got removed from the project (I might consider implementing them after overhauling the error reporting features of dk). Hoptoad error reporting got upgraded to the use the newer API. The generated rake tasks are more forgiving when rspec/cucumber or other gems are missing. The cron daemon got some love, allowing easier exception logging/notification for when scheduled tasks fail.

I&#8217;ll continue chipping away at the project, tidying up loose ends as they are reported, and start developing a proper test suite for everything.

Over the long term I&#8217;m hoping to reach the following goals:

  * Always running the eventmachine reactor (think node.rb)
  * Support for more modular daemons, including &#8216;single-file&#8217; daemons
  * Support for daemons inside Rails projects

Some things will probably get thrown out, like generating configs for god & monit. The more I use chef, the more I realize that those responsibilities lie with the infrastructure management (or devops), and not within the project itself. I&#8217;m aware this might cause an upset, however I firmly believe that a lighter and smaller daemon-kit will serve the greater community better.

Thanks for making daemon-kit the number 1 daemonizing project. Please share the love and send feedback, and more importantly use Github issues to log issues, feedback, and wishes.

 [1]: http://fourbeansoup.com
 [2]: http://twitter.com/joshowens
 [3]: http://www.mikeperham.com
 [4]: http://twitter.com/mperham
 [5]: http://github.com/mhutchin
 [6]: http://github.com/milann
 [7]: http://github.com/jgeiger
 [8]: http://github.com/merrells
 [9]: http://github.com/gcampbell
