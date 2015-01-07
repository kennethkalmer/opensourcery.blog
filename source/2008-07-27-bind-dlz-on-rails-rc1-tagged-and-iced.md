---
id: 60
title: BIND DLZ on Rails RC1 tagged and iced
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=60
permalink: /2008/07/27/bind-dlz-on-rails-rc1-tagged-and-iced/
tags:
  - bind
  - dlz
  - powerdns
  - projects
disqus_identifier: '60 http://www.opensourcery.co.za/?p=60'
---

It is with great excitement, and sadness that I announce the tag of [BIND DLZ on Rails RC1][1].

We were very motivated as a team to get this product, and the accompanying infrastructure in place so would could continue to enhance and expand our DNS infrastructure. We made two fatal mistakes in trying to achieve this goal:

**Understand your existing infrastructure**

We used the easy way out and blamed PowerDNS for some of our DNS does, where it ended up being out woes with TUPA, not PowerDNS. Typical I guess, since everyone else uses BIND, we&#8217;ll use BIND as well. We never went out to fully understand the problems not the solutions. We just decided to blindly drop an entire stack of services for a new one. Thats bad.

**Understand your new infrastructure**

Same goes for this. We checked out the BIND-DLZ patches, heard it was accepted into BIND itsef, and got excited. We could run everyone&#8217;s dream DNS server with a flexible MySQL 5 backend. Boy, what a mistake. We should have evaluated BIND DLZ first, before building an entire UI for it and then only testing it.

The whole of last week was spent trying to get BIND to behave. It would random crash without warning. I <a href="http://article.gmane.org/gmane.network.dns.bind9.dlz/1952" target="_blank">discussed this with the bind-dlz-testers list</a> over at SourceForge, who argued I should downgrade the MySQL client libraries to MySQL 4. For us this was easily possible since the MySQL slaves and DNS servers were different boxes, for others this might not be the case. As part of this excercise I had to learn how to update Gentoo ebuild&#8217;s, so I could <a href="http://bugs.gentoo.org/show_bug.cgi?id=180720" target="_blank">submit a fix to Gentoo as well for their net-dns/bind-9.5.1-p1 ebuild</a>.

Who&#8217;s to blame? Well, us. Not BIND, or the guys who developed the DLZ patches. There are plenty reports out there of issues with the MySQL client libs, but some very clever people have found <a href="http://www.ripe.net/ripe/meetings/ripe-55/presentations/forsberg-bind-dlz-experience.pdf" target="_blank">ingenious ways of working around it</a>. I personally think we have an odd combination of Hardened Gentoo & BIND issues.

**What happens next?**

Well, we&#8217;ll be sticking to PowerDNS for the time being, or maybe permanently. We&#8217;ll be planning our DNS offerings out in full, and then start to see how PowerDNS can accomodate us. If, and only if, it cannot, we&#8217;ll dive into the alternatives.

All the work is not lost, I&#8217;ve basically made a copy (not a fork) of the git repo and modified the entire application to run on the PowerDNS schema. So keep an eye out for [PowerDNS on Rails][2].

I won&#8217;t try to juggle branches, the differences are too big. However, I&#8217;ll be porting changes implemented in PowerDNS on Rails back to BIND DLZ on Rails. My hope is that someone picks up BIND DLZ on Rails and runs with it further.

Thanks to everyone for their interest in the project.

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails/
 [2]: https://github.com/kennethkalmer/powerdns-on-rails/
