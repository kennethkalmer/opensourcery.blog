---
id: 108
title: 'Open Source Rails projects, make sure you&#8217;re safe&#8230;'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=108
permalink: /2008/09/27/open-source-rails-projects-make-sure-youre-safe/
tags:
  - powerdns
  - security
disqus_identifier: '108 http://www.opensourcery.co.za/?p=108'
---

An impending doom? Possibly. There was a thread on the Rails Core list not too long ago, titled &#8220;[Cookie session security and open-source][1]&#8220;, and they covered what seems to be an obvious security flaw. I distinctly remember following the events as it happened and thought to myself it makes a lot of sense, and yet I fell victim to the same thing.

[PowerDNS on Rails][2] uses the cookie store, and until [b2ff9410de[...]][3] had both the session key and session secret hard coded in the *environment.rb* file.

It came down on my like a ton of bricks when I was moderating a comment by JGeiger on my previous post ([Using hoptoad in open source project deployments][4]). I quickly jumped to fix the code using a solution put out by [Trevor Turk][5] which requires users to set both the session key and session secret in their database.yml files.

I know this is not an optimal solution, but works until the Core team (and us) have found a reasonable solution to the problem.

As part of stating the obvious (you gotta love hindsight), I recommend anyone who is running PowerDNS on Rails in a production environment to run it over SSL. Apart from session hijacking woes, having your zone data readable as plain text is just as bad as allowing zone transfers to any DNS client&#8230;

 [1]: http://groups.google.com/group/rubyonrails-core/browse_thread/thread/4d43c1fa2485f3e3?hl=en
 [2]: /powerdns-on-rails/
 [3]: http://github.com/kennethkalmer/powerdns-on-rails/commit/b2ff9410de574b3e96cb952376ea82285f9f6a43
 [4]: /2008/09/26/using-hoptoad-in-open-source-project-deployments/
 [5]: http://almosteffortless.com/2007/12/27/configuring-cookie-based-sessions-in-rails-20/
