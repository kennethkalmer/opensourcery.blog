---
id: 121
title: Postfix log grep gist
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=121
permalink: /2008/10/23/postfix-log-grep-gist/
categories:
  - linux
  - postfix
tags:
  - bash
  - postfix
  - quickies
disqus_identifier: '121 http://www.opensourcery.co.za/?p=121'
---

Just a quickie to tell you about my (first) latest gist: <a href="http://gist.github.com/19021" target="_blank">http://gist.github.com/19021</a>

Basically search through the postfix maillog for a pattern, extract the postfix message id from each matched line, and then search through the log file for each corresponding line.

This rebuilds your original search with some more context, and makes it a snap to trace a message through its lifecycle&#8230;
