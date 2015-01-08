---
id: 187
title: Nanite agents now in daemon-kit
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=187
permalink: /2009/04/30/nanite-agents-now-in-daemon-kit/
tags:
  - amqp
  - daemon-kit
  - nanite
disqus_identifier: '187 http://www.opensourcery.co.za/?p=187'
---

My recent love affair with [AMQP][1] & [nanite][2] has been quite a nice boost to [daemon-kit][3]. First it got a neat AMQP consumer generator, and today it got a nanite agent generator with sample actor.

Here is how to get going quickly:

~~~
$ sudo gem install kennethkalmer-daemon-kit -s http://gems.github.com
$ daemon_kit myagent -i nanite_agent
$ cd myagent
$ ruby ./bin/myagent run
~~~

And in another console:

~~~
$ nanite-mapper -i
>> request('/sample/echo', 'ping') { |r| puts r.inspect }
~~~

You should get a ping message back from the sample actor.

The daemon-kit nanite agent implementation is more than just a replacement for the *nanite-agent* command line tool. It allows you to build more functionality into your agents as well. In my case I&#8217;m combining the cron features of daemon-kit with  the nanite agents to build a multi-purpose power daemon.

**Fine print**

This generator is still in it&#8217;s infancy and will undoubtedly have some changes moving forward, but so far it works just great in my simple tests. I&#8217;m publishing this to solicit some feedback from the nanite community in general.

Please follow the nanite README closely to ensure your nanite installation is working correctly. Ezra merged my changes to nanite, so the examples are working out the box again.

*Disclaimer: I&#8217;m still learning nanite and AMQP, so I&#8217;m definitely no authority on either and asking me for help might yield longer than expected replies while I figure stuff out myself!*

 [1]: /2009/04/19/to-amqp-or-to-xmpp-that-is-the-question/
 [2]: http://github.com/ezmobius/nanite
 [3]: http://github.com/kennethkalmer/daemon-kit
