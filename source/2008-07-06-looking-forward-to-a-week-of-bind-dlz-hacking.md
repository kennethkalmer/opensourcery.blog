---
id: 42
title: Looking forward to a week of BIND DLZ hacking
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=42
permalink: /2008/07/06/looking-forward-to-a-week-of-bind-dlz-hacking/
tags:
  - bind
  - dlz
disqus_identifier: '42 http://www.opensourcery.co.za/?p=42'
---

As part of keeping everyone up to date on the project, I&#8217;m posting this quick update on the coming week&#8217;s hacking on the project.

Last week we hit a critical bug in Tupa where we cannot use template records that use the %DOMAIN% token as the start of the content, appended by something else. As part of our current Postini integration process we have to change all our MX records to look something like this:

> @ IN MX 100 %DOMAIN%.sb2001a1.psmtp.com

This is trivial, but Tupa chokes, and subsequently our technicians also choke. So while I&#8217;m busy updating existing DNS records by hand, Keegan will be picking up a lot of BIND DLZ work during this week to make sure we can get battle tested in production in a few short days.

Stay posted as Keegan and myself push plenty of updates during the coming days.

I&#8217;ve also updated the [project page][1] to reflect a [Google Group][2] I&#8217;ve setup specifically for this project. Feel free to assault the group with queries and feedback.

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails
 [2]: http://groups.google.com/group/bind-dlz-on-rails
