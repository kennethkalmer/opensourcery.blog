---
id: 343
title: daemon-kit 0.3.0.rc2 is ready
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=343
permalink: /2013/09/26/daemon-kit-0-3-0-rc2-is-ready/
tags:
  - daemon-kit
disqus_identifier: '343 http://www.opensourcery.co.za/?p=343'
---

The second [0.3.0 release candidate][1] has been pushed to Rubygems. Please read the [0.3.0.rc1 announcement][2] for the changes between 0.2.x and that version.

**What changed since 0.3.0.rc1?**

[Safely][3] usage is now optional, see [#73][4] for the details. Safely is still included by default in the generated Gemfile, but to remove it you simply remove that one line. This was heavily inspired by Rails&#8217; default SASS behaviour.

The XMPP abstraction has also been fixed for blather versions ~> 0.8.0, so be sure to update the version by running *bundle update blather* and locking the version with &#8220;~> 0.8.7&#8243;.

Support for &#8220;freezing daemon-kit into vendor/daemon-kit&#8221; has been removed. In this age of bundler awesomeness, that functionality is quite useless. To use the edge version of daemon-kit simply update your Gemfile with the following:

~~~ruby
gem 'daemon-kit', github: 'kennethkalmer/daemon-kit'
~~~

Then run *bundle* and you&#8217;re all set. Oh, delete anything in *vendor/daemon-kit* too.

When generating a new daemon you can simply pass the &#8220;&#8211;edge&#8221; parameter to get a Gemfile that tracks Github instead of Rubygems:

~~~
$ daemon-kit vuvuzela --edge
~~~

Tracking edge is probably the best choice up until 0.3.0 final is released.

**Please give 0.3 a test drive**

Get going with:

~~~
$ gem install daemon-kit --pre
~~~

or update your Gemfile:

~~~ruby
gem 'daemon-kit', '~> 0.3.0.rc2'
~~~

Afterwards run the following to get your local daemon updated:

~~~
$ rake daemon_kit:upgrade
~~~

**Blocker for a 0.3 final**

There is only one blocker preventing a 0.3.0 final release. It is obscurely hidden in [#72][5], and affects daemons running on Ruby 2.0 and later. Mark Perham has already resolved the issue in Sidekiq, so I have some inspiration to work from.

After that I&#8217;ll very quickly increment the minor & patch versions with improvements and start deprecating features. The project has come a long way, and some baggage needs to be cleared out to ensure a bright future for the project.

Thanks for facing your daemons!

 [1]: https://github.com/kennethkalmer/daemon-kit/compare/v0.3.0.rc1...v0.3.0.rc2
 [2]: http://www.opensourcery.co.za/2013/09/11/daemon-kit-0-3-0-rc-is-ready/
 [3]: https://github.com/kennethkalmer/safely
 [4]: https://github.com/kennethkalmer/daemon-kit/issues/73
 [5]: https://github.com/kennethkalmer/daemon-kit/issues/72
