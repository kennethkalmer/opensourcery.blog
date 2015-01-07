---
id: 33
title: 'BIND DLZ Update: Templates now seem happy'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=33
permalink: /2008/06/15/bind-dlz-update-templates-now-seem-happy/
tags:
  - bind
  - dlz
  - projects
  - rails
disqus_identifier: '33 http://www.opensourcery.co.za/?p=33'
---

I&#8217;ve completed the zone templates in [BIND DLZ on Rails][1], unless I missed something obvious. I&#8217;ll first complete all the missing specs before continuing with the standard zone management tools.

Changes over the last four days include:

  * Prototip 2 test implementation, for DNS insight
  * Getting the $TTL of zone templates to behave the same way as normal zones
  * Fixed broken seed data
  * Restructured views to be more RJS friendly, and easier to manipulate with RJS

Lessons learned so far:

  * Flock interferes with prototype&#8217;s event listening, or maybe firebug in flock
  * Getting tables and nested forms to be manipulated by JS is not a walk in the park
  * UI design can actually show holes model design

Stay tuned for more changes coming this week, we have a hectic deadline to get this application production ready in a very short time.

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails
