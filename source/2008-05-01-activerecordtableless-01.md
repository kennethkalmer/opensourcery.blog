---
id: 20
title: ActiveRecord::Tableless 0.1
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=20
permalink: /2008/05/01/activerecordtableless-01/
categories:
  - ruby
tags:
  - activerecord
  - projects
disqus_identifier: '20 http://www.opensourcery.co.za/?p=20'
---

[ActiveRecord::Tableless][1] has just been released to [Rubyforge.org][2]

First made popular on the (now extinct) RailsWeenie.com fourms, the tableless model has been very popular. Why a tableless model? Read on…

**Overview**

ActiveRecord::Tableless allows you to create a ActiveRecord model that is not associated with a table in your database. This is a great way to exploit ActiveRecord’s validation features for simple tasks like validating the content of a contact form before sending an email.

Another great use for tableless models is mocking. I use ActiveRecord::Tableless extensively in the specs I write for some of my own ActiveRecord mixin’s without worrying about the tables or test databases being setup.

It works great for non-Rails applications too, just in case

**Credits**

The original forum post detailing the code is no longer available, not even in Google’s cache search. So unfortunately I cannot credit the original authors fully. The code does however appear on several other sites and is roughly the same than the code provided here.

 [1]: https://github.com/kennethkalmer/activerecord-tableless-models
 [2]: https://rubygems.org/gems/activerecord-tableless
