---
id: 80
title: MySQL Replication Client with SSL, gotcha
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=80
permalink: /2008/09/08/mysql-replication-client-with-ssl-gotcha/
tags:
  - mysql
  - powerdns
  - ssl
disqus_identifier: '80 http://www.opensourcery.co.za/?p=80'
---

As part of the PowerDNS on Rails project, and improving our own DNS infrastructure, I sat out today to configure 4 new DNS servers around the world. This will move a lot of our DNS traffic out of South Africa, while keeping some servers locally on the main networks (Internet Solutions & SAIX).

I rolled out MySQL replication with SSL enabled, you can Google for some good howto&#8217;s on the topic and I&#8217;ll give some posts below. Basically we have secure replication, and each DNS server is isolated in case of a disaster.

**The gotcha then?**

The MySQL docs, and some other howto&#8217;s indicate you should set the SSL client certificate details in your *my.cnf* file, under the *[client]* section. It makes sense, the slave is a client of the master. Appears not so with Gentoo&#8217;s mysql-5.0.60-r1 ebuild. It appears even less so with PowerDNS, who rightfully reads the *my.cnf* file as client.

**Cause and effect**

PowerDNS now tries to connect to the slave using the SSL details specified in the *[client]* section of the *my.cnf* file. This breaks, since you probably never configured your MySQL slave to have PowerDNS connect via SSL.

Secondly, it appears MySQL blatantly ignores the settings when used with replication, and you actually need to specify the client certificates in the *CHANGE MASTER TO* statement.

**Aftermath**

Nothing serious, was quick to piece together what was going on. Now I&#8217;ll have double digit DNS servers scattered around the globe near pearing point, with SSL encryption for the replication data. Brilliant, that really is resillient DNS!

**More reading**

  * MySQL Manual &#8211; <a href="http://dev.mysql.com/doc/refman/5.0/en/secure-connections.html" target="_blank">Using SSL for secure connections</a>
  * MySQL Manual &#8211; <a href="http://dev.mysql.com/doc/refman/5.0/en/replication-solutions-ssl.html" target="_blank">Setting up replication using SSL</a>
  * <a href="http://www.g-loaded.eu/2005/11/10/be-your-own-ca/" target="_blank">Be your own CA</a> &#8211; Not MySQL specific
  * <a href="http://boilinglinux.blogspot.com/2008/05/mysql-replication-with-ssl.html" target="_self">MySQL Replication with SSL</a>
  * <a href="http://www.option-c.com/xwiki/MySQL_Replication_with_SSL" target="_blank">MySQL Replication with SSL</a>

Hope this prevents any future missery for someone else.
