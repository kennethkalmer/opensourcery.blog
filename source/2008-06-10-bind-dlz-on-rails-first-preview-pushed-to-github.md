---
id: 32
title: BIND DLZ on Rails first preview pushed to Github
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=32
permalink: /2008/06/10/bind-dlz-on-rails-first-preview-pushed-to-github/
tags:
  - bind
  - projects
  - rails
disqus_identifier: '32 http://www.opensourcery.co.za/?p=32'
---

I&#8217;m proud to announce the first push to <a href="http://github.com/kennethkalmer/bind-dlz-on-rails/tree/master" target="_blank">Github</a> of the [BIND DLZ][1] on Rails project. Its still pretty much a work in progress, but this is the first draft and opens the door for feedback by the community before the project has evolved too far.

Highlights so far

  * Multiple roles (admins or domain owners)
  * Zone & Record Templates
  * Fairly good test coverage with RSpec
  * Some documentation

For those who are curious, its built using:

  * Rails 2.0.2
  * Haml 2.0
  * restful\_authentication plugin (and acts\_as\_state\_machine, role_requirement)
  * will_paginate
  * seed-fu
  * rspec and rspec\_on\_rails

**Installation**

This might be a little sketchy, apologies in advance. I&#8217;ll work on a proper document as part of the source code.

Requirements

  * Ruby 1.8.6
  * Rubygems v 1.0 or later
  * MySQL (other databases will work, although I haven&#8217;t tested them)
  * Git

After installing the prerequisites, you need to create a database for the application to use. By default it expects &#8220;*bind\_dns\_development*&#8221; as the database name, you can however change config/database.yml to point to anywhere.

To get the database structure in place, with some seed data to play with, run these commands

<pre>$ rake db:schema:load
$ rake db:seed</pre>

The seed data will create a single user called &#8220;admin&#8221;, with the password &#8220;secret&#8221;.

To start a server, do this

<pre>$ ./script/server</pre>

This shows you the interface on port 3000.

**Stay tuned**

Please watch/fork the <a href="http://github.com/kennethkalmer/bind-dlz-on-rails" target="_blank">repo</a> as appropriate, and file tickets on <a href="http://kennethkalmer.lighthouseapp.com/projects/11831-bind-dlz-on-rails" target="_blank">Lighthouse</a>. As I&#8217;m typing this post I realize you much documentation is still lacking for non-Rails developers.

**Thanks**

Thanks to <a href="http://www.ispinabox.co.za" target="_blank">ISP in a Box</a> for allowing us to build this project in company time and giving us the required infrastructure, support and human testing during the development, now and in the coming months.

 [1]: https://github.com/kennethkalmer/bind-dlz-on-rails
