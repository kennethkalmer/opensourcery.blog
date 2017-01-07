---
id: 140
title: Clear the log files of all your rails projects
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=140
permalink: /2008/11/21/clear-the-log-files-of-all-your-rails-projects/
tags:
  - gist
  - quickies
  - rails
disqus_identifier: '140 http://www.opensourcery.co.za/?p=140'
---

I hit a barrier last night where my virtual machine I use for Rails development ran out of space. I quickly checked around and saw my current Rails project had 800MB in log files (thanks autospec).

So I decided to quickly cook up this little bash script that I run from my top level working directory, and have it clear all the log files, in all my Rails projects.

Hope it helps.
