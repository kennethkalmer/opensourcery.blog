---
id: 18
title: Cleaning up capistrano deployments
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=18
permalink: /2008/04/28/cleaning-up-capistrano-deployments/
tags:
  - capistrano
  - quickies
disqus_identifier: '18 http://www.opensourcery.co.za/?p=18'
---

The basic &#8220;cap deploy:cleanup&#8221; does its job well, but can leave traces behind.

I recently picked up that one of my servers in a Rails cluster had plenty more release directories than its peers, and they were very old. I was baffled, how does this happen when I run &#8220;cap deploy:cleanup&#8221; religiously after a release has stabilized&#8230; I decided to figure out why, and how to dodge it. Who knows how many other release directories are scattered around the network.

It seems that cap gets the directory contents of the &#8220;releases&#8221; directory from the first server in its internal list. It then uses that directory content to remove stale releases from all servers. This is a sane approach, but things do go wrong and releases will build up over time.

Running the task once for every host seems the quick solution without messing with cap itself.

<pre>$ cap deploy:cleanup HOSTS=10.0.0.1</pre>

This gives each individual host a fresh start. From here, lather, rinse, repeat.

Later
