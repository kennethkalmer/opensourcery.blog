---
id: 153
title: Macro support for PowerDNS on Rails
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=153
permalink: /2009/01/04/macro-support-for-powerdns-on-rails/
tags:
  - macros
  - powerdns
disqus_identifier: '153 http://www.opensourcery.co.za/?p=153'
---

PowerDNS, and PowerDNS on Rails forms a critical part of our infrastructure here at inX, and over the holidays I&#8217;ve been busy adding support for macros to PowerDNS on Rails.

Macros allow a DNS administrator to setup a predefined sequence of steps that will later be applied to any domain they choose, via the web interface or API access.

Where is this used? Well, lets take a simple example related around web hosting. Lets say you have zone templates configured for three data centers, one in South Africa, one in Europe and one in the US. By default you&#8217;ll probably use one of these templates when new domains are added to the system. The template might contain everything you need for web hosting and email to work. Later the client asks to be shifted to another continent, for whatever reason, and you&#8217;ll have to update a load of records for that domain.

Macros solves this by allowing you to predefine several actions which either creates, removes or updates records for the domain. Macros can then be applied on any domain to have these changes take affect on that domain.

Just like zone templates, macros are available to owners and administrators alike.

[![Macros](2009-01-04-macro-support-for-powerdns-on-rails/powerdns-macros-300x234.png)](2009-01-04-macro-support-for-powerdns-on-rails/powerdns-macros.png)

I&#8217;ve also started creating a new official website for the PowerDNS on Rails project, and [it lives over here][1].

 [1]: http://kennethkalmer.github.com/powerdns-on-rails "Official PowerDNS on Rails Website"
