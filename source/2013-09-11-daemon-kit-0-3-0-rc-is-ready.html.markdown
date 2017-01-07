---
id: 337
title: Daemon-kit 0.3.0.rc1 is ready
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=337
permalink: /2013/09/11/daemon-kit-0-3-0-rc-is-ready/
tags:
  - daemon-kit
disqus_identifier: '337 http://www.opensourcery.co.za/?p=337'
---

I barely managed to get a [0.3.0 release candidate][1] out before today&#8217;s release of the [Ruby Rogues episode][2] on daemonizing Ruby projects, which focussed a lot on daemon-kit, but also general advice for going down this path.

Listen to the show if you haven&#8217;t already, it really went great.

Also, big shout out to Marc Bowes for looking after daemon-kit while I&#8217;ve been living the startup life. Thanks Marc!

**So what changed since 0.2.x?**

I ripped out the old nanite generator since the nanite project seems pretty much abandoned. It was initially added to help daemon-kit attract some mindshare in the early days, and it worked. But given the state of the nanite project today, we had to part ways. This alone is the reason for the minor version bump.

This leads us to starting with a more semantic versioning approach. Going forward there is going to be plenty more minor version bumps leading up to a 1.0.0 release and beyond. My original version policy sucked, daemon-kit should have been 1.0.0 already since it is being deployed to production all over the world with great success.

I believe that semver also demands better transparency, so I&#8217;ve added travis support and got all the tests to pass. I&#8217;ve also switched a lot of old generator specs over from old Rubigen dependent test/unit tests to using the excellent [aruba][3] gem. I&#8217;m also dabbling with using [Relish for documentation][4].

I&#8217;ve also added us to [CodeClimate][5] so we can get the code up to a 4.0. It started off as a 3.1, which surprised me (in a good way).

Some documentation files have been updated to Markdown, and if the Relish docs work out well will be moved to there.

Please give 0.3 a test drive

~~~
$ gem install daemon-kit --pre
~~~

or add it to your Gemfile

~~~
gem 'daemon-kit', '~> 0.3.0.rc1'
~~~

No real bug fixes except for running &#8216;daemon-kit&#8217; without any arguments now shows a friendly help message.

I&#8217;ll push the 0.3.0 final in the next few days, I just want to expand the cucumber coverage off all the generators.

After that I&#8217;ll very quickly increment the minor & patch versions with improvements and start deprecating features. The project has come a long way, and some baggage needs to be cleared out to ensure a bright future for the project.

Thanks for facing your daemons!

 [1]: https://github.com/kennethkalmer/daemon-kit/compare/v0.2.3...v0.3.0.rc1
 [2]: http://rubyrogues.com/122-rr-daemons-with-kenneth-kalmer/
 [3]: http://github.com/cucumber/aruba
 [4]: https://relishapp.com/kennethkalmer/daemon-kit
 [5]: https://codeclimate.com/github/kennethkalmer/daemon-kit
