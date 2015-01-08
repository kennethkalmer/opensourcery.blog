---
id: 179
title: 'Ruby Enterprise Edition on Gentoo with newer OpenSSL (>0.9.8i)'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=179
permalink: /2009/04/21/ruby-enterprise-edition-on-gentoo-with-newer-openssl-098i/
tags:
  - openssl
  - patch
  - ree
disqus_identifier: '179 http://www.opensourcery.co.za/?p=179'
---

**UPDATE 2009-04022: **[Ruby Enterprise Edition 20090421 released a couple of hours after the original post][1]. Now includes the OpenSSL patch from Gentoo&#8217;s Portage.

**UPDATE: **The upcoming release of Ruby Enterprise Edition [might include the suggested][2] patch, if we get enough +1&#8217;s on the list. Test and go vote!

Keeping your gentoo up to date almost means sacrificing [Ruby Enterprise Edition][3] because [it doesn&#8217;t compile against OpenSSL 0.9.8i or later][4]. This isn&#8217;t the fault of the Phusion guys, it comes from upstream Ruby.

Gentoo&#8217;s portage contains some patches for compiling stock Ruby 1.8.6 with later versions of OpenSSL, backported from Ruby 1.8.7. This patch also applies cleanly to Ruby Enterprise Edition 20090201, and here is how to do it from inside your unpacked Ruby Enterprise Edition tarball.

~~~
$ cd source
$ patch -p3 < /usr/portage/dev-lang/ruby/files/ruby-1.8.6-openssl.patch
$ cd ..
$ sudo ./installer
~~~

This keeps your OpenSSL library up to date, and keeps Ruby Enterprise Edition happy.

 [1]: http://blog.phusion.nl/2009/04/22/ruby-enterprise-edition-186-20090421-released
 [2]: http://http://groups.google.com/group/emm-ruby/browse_thread/thread/1d7ffc650626fd36
 [3]: http://www.rubyenterpriseedition.com
 [4]: http://groups.google.com/group/emm-ruby/browse_thread/thread/1d7ffc650626fd36
