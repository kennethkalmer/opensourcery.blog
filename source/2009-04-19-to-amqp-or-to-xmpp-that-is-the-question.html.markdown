---
id: 173
title: To AMQP or to XMPP, that is the question
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=173
permalink: /2009/04/19/to-amqp-or-to-xmpp-that-is-the-question/
tags:
  - amqp
  - jabber
  - messaging
  - xmpp
disqus_identifier: '173 http://www.opensourcery.co.za/?p=173'
---

Some time ago I started a series of blog posts [[1][1],[2][2]] on Ruby and messaging. Most of the series is still in draft format and has to be completed. It&#8217;s a topic I&#8217;ve been very interested for some time, and have monitored the space quite closely looking for new implementations and collecting presentations and links as I go along. I&#8217;ve been a fan of Jabber (XMPP) for some time now, but it has some smells, to me at least&#8230;

First, some background. I&#8217;m the chief utopian at a South African ISP, [inX][3], and most of my current work focusses on finishing off the fourth generation of our flagship project [ISP in a Box][4]. ISP in a Box is essentially a Rails frontend to a variety of services we procure and reprovision to resellers, which in turn sell to their clients. Apart from coping with a lot of models and extremely complex business processes, we also have to cope with procuring and provisioning services.

In this post I&#8217;ll aim to give some insight into our provisioning processes, and more specifically how I plan to implement our hosting provisioning over the coming days.

We exclusively use the excellent [ruote Worflow Engine][5] by [John Mettraux][6] to drive our procurement/provisioning processes, instead of overly complex state machines. As part of this I&#8217;ve implemented a Jabber Participant/Listener pair of classes for ruote, allowing any part of the workflow to be shelled out to a Jabber bot for processing, and continuing the workflow when done. This has worked great so far, but the requirements of our hosting services are somewhat more. This made me sit down and think, and [I announced today][7] that I&#8217;ll be doing a &#8220;pen and paper&#8221; SWOT on XMPP, AMQP and REST. What I came up with, is not a textbook SWOT, but at least a look at AMQP from an XMPP point of view. And it was interesting indeed, so much so that I&#8217;ve made up my mind to move to AMQP from XMPP. Here&#8217;s what happened&#8230;

**The smells of XMPP**

For the record, I really love XMPP as a protocol and the possibilities made possible by it. I&#8217;ve written a good couple of clients, for fun and for serious production use at our company. In my mind, here is a &#8220;SWOT&#8221; on XMPP from someone who works with it frequently.

<table border="0">
  <tr>
    <th>
      Strengths
    </th>

    <th>
      Weaknesses
    </th>
  </tr>

  <tr>
    <td>
      <ul>
        <li>
          Presence &#8211; Know if your bots are running
        </li>
        <li>
          Quick &#8211; Easy to get going (emerge ejabberd; gem install xmpp4-simple)
        </li>
        <li>
          Queue like &#8211; ejabberd will store &#8220;offline chats&#8221;
        </li>
        <li>
          Feedback and control via pidgin
        </li>
        <li>
          Explicit identities (JID)
        </li>
      </ul>
    </td>

    <td>
      <ul>
        <li>
          Roster &#8211; Managing relationships is a nightmare
        </li>
        <li>
          Roster &#8211; High number of presence updates can be large overhead
        </li>
        <li>
          PubSub &#8211; Feels like an afterthought to me
        </li>
        <li>
          REST bridge (hence <a href="http://github.com/kennethkalmer/ratpack">ratpack</a>)
        </li>
        <li>
          File transfers are an &#8220;extension&#8221; to protocol and daemons
        </li>
      </ul>
    </td>
  </tr>
</table>

NOTE: I personally feel that most of the times we implement XMPP where we should be implementing a real queueing protocol. This holds especially true, if you like me, counts on ejabberd&#8217;s persisting of messages while the client is down.

For me personally the *biggest smell* in XMPP is the roster, at least for automated clients. This shows in other implementations too, [Vertebra][8] implemented a gatekeeper called Herault. I assume that with Herault in place you don&#8217;t care about roster management, and all bots will freely accept invitations from each other, and ask Herault whether the commands should be accepted or not. This is a perfectly sound plan, permitted your XMPP server is well secured and doesn&#8217;t allow inter-domain communications, ie you&#8217;re running inside a wall of trust.

**The promised land of AMQP**

I&#8217;m typing this without ever having written a single piece of AMQP code (be it producer or consumer). The &#8220;SWOT&#8221; below is what I&#8217;ve extracted from various online sources over the last couple of weeks, and especially today. I&#8217;ve got a number of requirements that needs to be fulfilled first:

  * Peer to peer implementation of &#8220;bots&#8221; or &#8220;agents&#8221;
  * Identity driven commands -> &#8220;Server 1: Create new site&#8221;, &#8220;Server 2: Suspend site&#8221;
  * Unrestricted &#8220;bot&#8221; to &#8220;bot&#8221; communication
  * File transfers (big files)
  * No more roster management

Now the scary part is that all the above requirements can be fulfilled with XMPP. The implementation would smell however.

<table border="0">
  <tr>
    <th>
      Requirement
    </th>

    <th>
      XMPP
    </th>

    <th>
      AMQP
    </th>
  </tr>

  <tr>
    <td>
      Peer to peer communication
    </td>

    <td>
      Roster management (-1)
    </td>

    <td>
      Unique named queues (+1)
    </td>
  </tr>

  <tr>
    <td>
      Identity driven commands
    </td>

    <td>
      Roster management (-1)
    </td>

    <td>
      Unique named queues (+1)
    </td>
  </tr>

  <tr>
    <td>
      File transfers
    </td>

    <td>
      File transfer proxy configuration (-1)
    </td>

    <td>
      Supported on the wire (+1)
    </td>
  </tr>

  <tr>
    <td>
      No roster management
    </td>

    <td>
      Implement copy of Vertebra&#8217;s Herault (-1)
    </td>

    <td>
      Unique named queues (+1)
    </td>
  </tr>
</table>

I hope the table above shows how blurred the lines are, and how difficult it can be to make a decision between the two protocols. Below is my non-textbook &#8220;SWOT&#8221; of AMQP.

<table border="0">
  <tr>
    <th>
      Strengths
    </th>

    <th>
      Weaknesses
    </th>
  </tr>

  <tr>
    <td>
      <ul>
        <li>
          No rosters to manage &#8211; Use queues
        </li>
        <li>
          Security managed inside the broker (at least with RabbitMQ)
        </li>
        <li>
          One to one (private) communication
        </li>
        <li>
          One to many (fan out) communication
        </li>
        <li>
          File transfer on the wire
        </li>
        <li>
          REST interfaces in the making (RestMS)
        </li>
      </ul>
    </td>

    <td>
      <ul>
        <li>
          Presence &#8211; Know if your producers/consumers are running
        </li>
        <li>
          Explicit Identity &#8211; (JID)
        </li>
        <li>
          Not so quick yet (RabbitMQ ebuild only came into portage <a href="http://twitter.com/asynchronaut/statuses/1558873331">today</a>)
        </li>
      </ul>
    </td>
  </tr>
</table>

**In Summary**

Both protocols are great, and the differences are not obvious at first. XMPP is easily mistaken as a message queue, especially because of the &#8220;offline chat&#8221; features in Jabber daemons and the inherently &#8220;targetted messages&#8221;. AMQP supports all of this, and so much more, without the need for roster management or Heraults. The only thing that I&#8217;ll miss from XMPP is the presence features. All my bots currently &#8220;talk to me and members of our support team&#8221;. I&#8217;ll implement this in my AMQP producers/consumers irrespective.

XMPP is built for one-on-one communication, with &#8220;broadcasting&#8221; supported by a protocol extension called PubSub. AMQP inherently supports one-on-one and one-to-many communication through it&#8217;s clever message/exchange system.

Going forward, I&#8217;m starting with the excellent [nanite][9] project from [Ezra][10]. I&#8217;ll probably work on bringing AMQP comsumers/producers into ruote this week, as well as implementing a nanite actor/master combo for ruote as well.

A great and timely [post on RubyInside][11] higlights [RabbitMQ][12] and some presentations to watch.

Please chime in on the comments, admittedly I might have buttered up AMQP due to my recent excitement, but I have a &#8220;gut feeling&#8221; it will payoff better in the future than XMPP. XMPP still rocks, I&#8217;ve just been using it as the wrong tool for the job, and I fear others have done the same.

 [1]: /2008/07/07/messaging-and-ruby-part-1-the-big-picture/ "Ruby and Messaging Part 1 - The Big Picture"
 [2]: /2008/11/07/ruby-and-messaging-part-2-giving-rails-a-break/ "Ruby and Messaging Part 2 - Giving Rails a Break"
 [3]: http://www.inx.co.za "Internet Exchange"
 [4]: http://www.ispinabox.co.za/
 [5]: http://ruote.rubyforge.org
 [6]: http://jmettraux.wordpress.com/
 [7]: http://twitter.com/kennethkalmer/status/1557190531 "after shopping, a big swot analysis of XMPP, AMQP & REST for our ISP services provisioning platform"
 [8]: http://github.com/engineyard/vertebra
 [9]: http://github.com/ezmobius/nanite
 [10]: http://brainspl.at/
 [11]: http://www.rubyinside.com/rabbitmq-a-fast-reliable-queuing-option-for-rubyists-1681.html
 [12]: http://www.rabbitmq.com/
