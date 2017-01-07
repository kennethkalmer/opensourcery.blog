---
id: 34
title: From svn to git, handling non-standard repo layouts
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=34
permalink: /2008/06/16/from-svn-to-git-handling-non-standard-repo-layouts/
tags:
  - git
  - quickies
  - svn
disqus_identifier: '34 http://www.opensourcery.co.za/?p=34'
---

Today I finally had to &#8220;extract&#8221; a project from one of our biggest repos as part of a git migration plan. I&#8217;ve converted most of the other smaller projects in the same repo over using just their trunk, and it has worked without any noticeable issues. Now the project in question has several active branches and important tags. Our repo layout is something to be a shamed of, and git-svn likes &#8220;standard&#8221; subversion layouts.

I found <a href="http://kerneltrap.org/mailarchive/git/2007/10/11/335050" target="_blank">this thread</a> on KernelTrap, where one user has a similair layout to ours and faced the exact same predicament. The thread is interesting, and the people offer some good tips and advice. Although most of them just seemed &#8220;wrong&#8221;.

I proceeded to get a copy of our live repo onto my laptop for a simple test. Using a quick svnadmin dump/load combo I had a copy to play with. I sat with a team member, and several svn manipulations later we had restructured that project&#8217;s layout to be more svn-like. I then commenced to use the standard git-svn import tool and it pulled in all the branches, tags and trunk for the project in without breaking a sweat.

So, importing from svn with full history from a non-standard repo layout isn&#8217;t a daunting task after all.

*Just one friendly warning though, if possible, get rid of as many unused branches and tags as possible before importing into git. The full history can get very messy in some cases, and in others a clean slate will be welcomed by the team&#8230;*

Hope this helps someone else to jump ship easily :)

