---
id: 36
title: BIND DLZ Update
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=36
permalink: /2008/06/30/bind-dlz-update/
tags:
  - bind
  - dlz
  - projects
disqus_identifier: '36 http://www.opensourcery.co.za/?p=36'
---

Howdy all

Since we got mentioned on the [Rails Envy Podcast #34][1], interest has been picking up in the project, and I&#8217;ve been drenched in other work&#8230; But not to worry, the project won&#8217;t die, and we actually desperately need it ourselves, even more now than ever.

Development will be picking up again near the end of the week to get the interfaces in some kinda shape before moving onto sample API clients, PowerDNS convertion tools, and macros!

Macros? Well, you see, we&#8217;ve been working brutally hard over the last couple of weeks to get Postini integrated tightly into ISP in a Box. Most of it is nearing completion now, but several thousand mailboxes still need to be integrated into Postini. One step of this integration process that has to happen for every domain is MX record updates. This is where the idea of macros came from, and after defining it in my head I quickly realized it will surely enjoy widespread use once implemented.

Pass me your thoughts on the <a href="http://kennethkalmer.lighthouseapp.com/projects/11831-bind-dlz-on-rails/tickets/22-add-support-for-update-macros" target="_blank">ticket I opened at LightHouse</a>.

Ciao

 [1]: http://www.railsenvy.com/2008/6/20/rails-envy-podcast-episode-034
