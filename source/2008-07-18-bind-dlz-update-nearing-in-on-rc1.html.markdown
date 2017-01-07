---
id: 45
title: 'BIND DLZ Update: Nearing in on RC1'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=45
permalink: /2008/07/18/bind-dlz-update-nearing-in-on-rc1/
tags:
  - bind
  - dlz
  - projects
  - rails
disqus_identifier: '45 http://www.opensourcery.co.za/?p=45'
---
**UPDATE (Jul 22, 2008):** I don&#8217;t have connectivity at home at the moment, so I&#8217;ll roll our production systems over to BIND (and BIND DLZ on Rails) from PowerDNS and Tupa in the morning. Based on the initial feedback from our support team I&#8217;ll either address small bugs we overlooked, or tag RC1, whichever comes first.

Just a quick update, we&#8217;re closing the gap rapidly on pushing RC1 to Github. Hopefully that happens by the weekend. We&#8217;ll also be rolling it into production use to iron out any last remaining issues that didn&#8217;t surface from our lab tests/reviews.

We just have one issue to overcome with will_paginate and our custom scoped finders for Zones, then I&#8217;ll push to Github.

In preparation (and celebration) I&#8217;ve added the [project to Ohloh][1] as well for some added metrics and publicity. See the badge below, and on the [updated project page][2].

<script src="http://www.ohloh.net/projects/15589/widgets/project_thin_badge" type="text/javascript"></script>

 [1]: http://www.ohloh.net/projects/bind-dlz-on-rails
 [2]: http://github.com/kennethkalmer/bind-dlz-on-rails
