---
id: 10
title: The real power of open-source
author: Kenneth Kalmer
layout: retro
guid: http://wordpress/2006/02/01/the-real-power-of-open-source/
permalink: /2006/02/01/the-real-power-of-open-source/
categories:
  - linux
  - mysql
  - policyd
  - postfix
disqus_identifier: '10 http://wordpress/2006/02/01/the-real-power-of-open-source/'
---

My first post in a while, I have seriously neglected the whole blog&#8230;

Back to business, this blog was conceptualized to focus on some of the real benefits of using open-source software in business. Not the kind of business that Novell and IBM try to make of open-source, but small businesses seeking to gain an advantage in a very competitive market space.

Today this power shined through dramatically again, through a little piece of software called [policyd][1]. Policyd is a greylisting service built for [Postfix][2] (the ever so popular MTA) and allows anyone with a mail server to implement greylisting, blacklisting, whitelisting and a host of other features in the fight against spam.

I needed to change the way policyd used the [MySQL][3] backend, and in doing so it meant editing C code that I know nothing about. It turn out to be relatively easy when you apply common sense and all the knowledge you&#8217;ve gained from coding in interpreted languages all your life. So I need to be able to prefix the tables in the MySQL database used by policyd in order to prevent clashes with other mail-related software sharing the same database. It is scheduled for the next major release version, but I needed this feature today. So after skimming through some of the .c files I realized that this wouldn&#8217;t be a too big feat&#8230;

It took me an hour, more or less, to complete modify every single SQL statement in the code, add new configuration directives and create a patch that I submitted to the policyd-users list for testing. Currently I&#8217;m still testing as well, and everything looks 100%.

This allows me to actually adapt software in an hour to fit my needs. This is the real power of open source. Imagine the time and effort it would take to consult with the developers of proprietary software to get such a minor change done. Even if I push my rates per hour up 10 fold, it would not compare to the cost of getting proprietary software adapted quickly and easily.

And in the true spirit of open-source (blatantly ignoring any licenses) the patch is available on the list archive pages of the policyd-users mailing list at SourceForge. If you need it, grab it here: [http://sourceforge.net/mailarchive/forum.php?thread\_id=9613438&forum\_id=46105][4]

 [1]: http://policyd.sourceforge.net
 [2]: http://www.postfix.org
 [3]: http://www.mysql.com
 [4]: http://sourceforge.net/mailarchive/forum.php?thread_id=9613438&#038;forum_id=46105
