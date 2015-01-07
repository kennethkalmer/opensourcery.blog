---
id: 35
title: Firefox 3 and the apparent random SSL errors
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=35
permalink: /2008/07/02/firefox-3-and-the-apparent-random-ssl-errors/
tags:
  - gentoo
  - ssl
disqus_identifier: '35 http://www.opensourcery.co.za/?p=35'
---

Strange days we live in, especially when our browsers trip of bugs in encryption libraries on the servers&#8230; [David Smalley][1] neatly pointed out how upgrading OpenSSL to at least 0.9.8h solves the cryptic Firefox 3 SSL errors we&#8217;ve been seeing on some our sites.

`Secure Connection Failed An error occurred during a connection to xyz-abe.com SSL received an unexpected Change Cipher Spec record. (Error code: ssl_error_rx_unexpected_change_cipher) `

Currently the package in question is still masked in gentoo, so upgrade as follows:

<pre>
# echo &#8216;=dev-libs/openssl-0.9.8h-r1&#8242; >> /etc/portage/package.unmask
# emerge -av openssl
</pre>

Once done, follow the instruction given by portage to rebuild the packages still using the old versions of OpenSSL.

Thanks David

 [1]: http://davidsmalley.com/2008/6/22/firefox-3-triggers-an-openssl-bug
