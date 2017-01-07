---
id: 101
title: Using hoptoad in open source project deployments
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=101
permalink: /2008/09/26/using-hoptoad-in-open-source-project-deployments/
tags:
  - git
  - hoptoad
  - quickies
disqus_identifier: '101 http://www.opensourcery.co.za/?p=101'
---

It came down on me like a ton of bricks when I deployed the [audit updates][1] to our production [PowerDNS on Rails][2] setup, [hoptoad][3] isn&#8217;t installed and any errors would just be gone and forgotten.

The solution is pretty simple, if you use git. This quicky will show you how I&#8217;m currently doing it.

**Multiple remote repos**

All our projects have their *origin* on our own servers, and then either have &#8220;github&#8221; or &#8220;rubyforge&#8221; remotes for public changes. This works very well, especially allowing the team here to work on ideas for a couple of days and deploy to a staging/production server for review. Only once we&#8217;re happy do we push the code back to the public.

Basic idea is that our public master branches should always be deployable. Nothing sucks more than getting a OSS project and it doesn&#8217;t work out the box&#8230;

**Enter the deploy branch**

We all have a tracked &#8220;deploy&#8221; branch, which exist only in our private repos, not on Github/RubyForge. This deployment branch was used just for our capistrano recipes. As of this week I decided to through hoptoad in the mix as well, which great reward already.

The principle is so simple, hopefully the flow below explains the process.

![Flow of merging master branch into deploy branch continually](2008-09-26-using-hoptoad-in-open-source-project-deployments/git-master-deploy.png)

Master is either your code, or a clone of someone else&#8217;s, and the deploy branch contains your modifications for your environment. In our case its capistrano recipes and hoptoad, but could include New Relic&#8217;s RPM as well (or anything else).

The deploy branch should have only additions, and no other changes are made to the deploy branch ever. If you accidently merge deploy back to master, you&#8217;ll have a tough time undoing the damage.

**Capistrano config?**

Well, if you maintain your own remote repo of another project, then make sure that repo has your deploy branch at configure capistrano like such:

~~~ruby
set :branch, "deploy"
~~~

If you don&#8217;t want to maintain your own remote repo, but want a local deploy branch, you&#8217;ll have to switch to copy deployment recipe (something like this):

~~~ruby

set :deploy_via, 'copy'
set :copy_strategy, :export
set :copy_cache, true
set :copy_exclude, ['.git']
set :repository, '.'
~~~

*BIG FAT DISCLAIMER: I&#8217;ve never used the above copy strategy myself, so I cannot vouch for it!*

**Results?**

Well, this neat feature of git allows us to deploy and run our OSS projects as if we were the only users. Sensitive information is not exposed to the world, but is still recorded by hoptoad. It allows us to get the real exceptions as they happen in the wild, without guessing what happened when some logs a &#8220;It doesn&#8217;t work!!&#8221; ticket.

 [1]: /2008/09/25/powerdns-on-rails-now-sports-basic-audits/
 [2]: https://github.com/kennethkalmer/powerdns-on-rails/
 [3]: http://www.hoptoadapp.com
