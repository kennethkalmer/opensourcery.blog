---
id: 265
title: Rails specs not running under Ruby 1.9 ?
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=265
permalink: /2009/09/27/rails-specs-not-running-under-ruby-1-9/
tags:
  - rails
  - rspec
  - ruby19
disqus_identifier: '265 http://www.opensourcery.co.za/?p=265'
---

I spent some time getting [PowerDNS on Rails][1] to run on Ruby 1.9.1, which ended up being very easy due to the small amount of plugins & gems used by the project. The only change I had to make myself was to the [acts\_as\_audited][2] plugin, where the [one-line fix got merged upstream][3].

The worst part of the process was getting the specs to run with *rake spec*. Using *./script/spec* it worked on individual specs and on all the specs worked as advertised, but *rake spec* didn&#8217;t do anything.

After a lot of time spent in the debugger I wasn&#8217;t any wiser. The only difference was that in Ruby 1.8 the example groups were fully loaded, and in Ruby 1.9 they were empty. I gave up and started searching relentlessly for some information on the issue. I couldn&#8217;t find anything, until I found an indirect solution on the [rspec wiki][4]. It seems that if you have any versions of the test-unit gem after the 1.2.3 release installed, your Rails specs will simply not run. For me, removing test-unit 2.0.3 made the difference and the specs ran properly. PowerDNS on Rails has now joined the ranks of my Ruby 1.9 compatible projects.

 [1]: http://github.com/kennethkalmer/powerdns-on-rails
 [2]: http://github.com/kennethkalmer/acts_as_audited
 [3]: http://github.com/collectiveidea/acts_as_audited/commit/02e35ac368f3125887c4752a39610f5e914ff6b7#L0L40
 [4]: http://wiki.github.com/dchelimsky/rspec/ruby-191
