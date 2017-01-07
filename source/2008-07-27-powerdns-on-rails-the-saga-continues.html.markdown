---
id: 64
title: PowerDNS on Rails, the saga continues
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=64
permalink: /2008/07/27/powerdns-on-rails-the-saga-continues/
tags:
  - dns
  - powerdns
  - projects
disqus_identifier: '64 http://www.opensourcery.co.za/?p=64'
---

After a misrable production implementation of BIND on a MySQL backend, we were forced to re-evaluate our use of PowerDNS, and what happens to the [BIND DLZ on Rails][1] project.

I&#8217;m glad to announce that [PowerDNS on Rails][2] will be taking over where BIND DLZ on Rails left off.

It&#8217;s been a crazy three days of refactoring, but the code is now fully operational and we have our first production implementation (complete with clients using the REST interface). It&#8217;s an exciting time for the project, over the next couple of weeks I&#8217;ll be ironing out some grey areas of PowerDNS with its users and I&#8217;ll be improving the UI significantly (as well as sneaking in new features).

This time I&#8217;ll hold back on promises of release candidates, instead I&#8217;ll just tag them and announce them afterwards.

I&#8217;ll also be posting some interesting Rails tips, especially since I had to bend ActiveRecord in ways I didn&#8217;t thought possible to cope with the PowerDNS schema. Thanks to everyone who made RSpec, without it this refactoring job would have been a disaster from the word go.

Here is to the future!

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails/
 [2]: https://github.com/kennethkalmer/powerdns-on-rails/
