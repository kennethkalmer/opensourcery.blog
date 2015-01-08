---
id: 302
title: Safely weekend updates
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=302
permalink: /2011/05/07/safely-weekend-updates/
tags:
  - safely
disqus_identifier: '302 http://www.opensourcery.co.za/?p=302'
---

I took some time today and released three new versions of [Safely][1] in a row, 0.1.0, 0.2.0 and 0.3.0. Safely also has a nice [wiki][2] now which breaks down exactly how to use the different parts.

I&#8217;m just going to summarize here, you can find more information in the repo and on the wiki.

* 0.1.0 &#8211; Cleaned up Hoptoad support and added support for exception mails.
* 0.2.0 &#8211; Added a Log strategy for logging exceptions to the specified logger instance.
* 0.3.0 &#8211; Added support for logging all exceptions to a backtrace log when a Ruby application terminates abnormally.

Worth noting is the backtrace support in 0.3.0, which to me has been a super reliable feature of [daemon-kit][3]. When your program dies spontaneously (or from an unhandled exception), you&#8217;re usually left to wonder what just happened. With the new Backtrace class you will get the insight you require on a per-process basis in their own logs. Check out the [Backtrace][4] page on the wiki for more information.

I think for the time being I&#8217;m done with Safely, unless some bugs pop in. I&#8217;m contemplating a Rack middleware as well, but I fear for duplicating the efforts of others. If you&#8217;d like to have a Safely middleware, file an issue on Github (or vote it up if someone beat you to it).

I&#8217;m looking forward to ripping out this functionality from daemon-kit and bundling in Safely to do the dirty work. It is much better tested than daemon-kit&#8217;s implementation and feels cleaner overall.

 [1]: https://github.com/kennethkalmer/safely
 [2]: https://github.com/kennethkalmer/safely/wiki
 [3]: https://github.com/kennethkalmer/daemon-kit
 [4]: https://github.com/kennethkalmer/safely/wiki/Backtrace
