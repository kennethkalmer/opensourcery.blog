---
id: 37
title: 'Messaging and Ruby (Part 1) &#8211; The Big Picture'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=37
permalink: /2008/07/07/messaging-and-ruby-part-1-the-big-picture/
categories:
  - Messaging and Ruby
tags:
  - messaging
  - ruby
disqus_identifier: '37 http://www.opensourcery.co.za/?p=37'
---

_Rails doesn&#8217;t scale._

Now that I have your attention, lets forget scaling all together and instead start focusing on how you can give Rails a break using messaging or &#8216;backgrounding&#8217;. This is the first in a series of articles where I&#8217;m combining my own research and experience together to a) prevent me from making the same mistakes in future, and b) hopefully help someone else to not make the same mistakes I did.

**Prelude**

Ever since I&#8217;ve read [Distributed programming with Jabber and EventMachine][1] I&#8217;ve been baffled by the almost endless possibilities this offers. I&#8217;ve shared this knowledge with several people, who got excited too, but not as excited as I did. Then I read about [Vertebra on Ezra&#8217;s blog][2] and almost lost my mind, shared this knowledge again and got a more enthusiastic response. Since then I&#8217;ve been scouring the net for more information and examples on using Jabber for distributed programming, as well as alternatives, since something was not entirely right in the equation.

Up until now I&#8217;ve used some insane combinations of Distributed Ruby, SQS, &#8220;Roll your own ActiveRecord queue&#8221;, REST and who even knows what else to achieve some levels of &#8216;scalability&#8217; and &#8216;asynchronous processing&#8217;.

Each project I work on have varying demands, from being ready to survive a Slashdotting all the way down to integrating with several desperate systems. Each one has its own expectations in terms of processes, business rules, and reporting on &#8220;background tasks&#8221;. It is quite a colorful affair I assure you. Now on each iteration I try something else, something new, something better. And they do get better, so I&#8217;m proud of the work I&#8217;ve done, and even more proud of my team members keeping up with the frantic evolution of the code everywhere.

However, this roll-your-own messaging systems are not scalable or reliable. You need the wisdom of crowds at your disposal. You need to draw on the knowledge of guys who&#8217;ve built systems for Fortune 500&#8217;s, built systems for telco&#8217;s, built systems for financial markets, built systems for medical care, built systems for aviation, etc.

Why? These guys have faced obstacles we can never imagine ,and they&#8217;ve overcome them. Through the years their knowledge has become available to us, and we must apply it. I&#8217;m sure if Twitter thought like a telco, and built Twitter the way a telco would, it would have never broken a sweat handling all those tweats.  But I&#8217;m not one to criticise, on with the story.

**What is messaging, and why is it important?**

Good question! [Wikipedia][3] sums it up like this:

> There are two main senses of the word &#8220;message&#8221; in computer science: messages passed within software, which may or may not be human-readable, and human-readable messages delivered via computer software for person-to-person communication.

We&#8217;ll be focussing on the first sense, &#8220;messages passed within software&#8221;.

**Why is messaging important?**

It allows us to build systems that have the following characteristics:

  1. Snappy websites that don&#8217;t block while performing expensive operations (sending mail, resizing photo&#8217;s, encoding videos, etc).
  2. Horizontal scalability, just throw in more instances of your program to speed up processing
  3. Loosely coupled components that merely &#8216;talk&#8217; to each other
  4. Ability to easily replace Ruby with something else for specific tasks

By passing simple messages around between different processes, or systems, we can build an ecosystem from smaller, more specialized components and then allow users to interact with the ecosystem as whole, as opposed to a monolithic compound.

Nature has proven over and over again how effective ecosystems are at surviving by evolving. Having loosely coupled components that exist independently, but talk to each other via messages, allows you to build extremely powerful systems, that would by virtue, scale indefinitely and evolve constantly.

**Awesome! How do I do it?**

<span style="text-decoration: line-through;">It&#8217;s quite simple, you need this gem, that app, several servers, big dollars</span>. You first need to understand a couple of concepts. This is very important, and this was my biggest mistake. There is no shortage of ways to perform distributed programming or to run expensive operations asynchronously, and this list is not even a chip off the iceberg.

In my experience as a Rails and Ruby developer, I&#8217;ve dabbled in a few different ways to solve the asynchronous and distributed programming problems, each with their own merits (and demerits). Each of these problems and proposed solutions are covered this series, so I&#8217;m only gonna touch on them briefly now.

*Asynchronous processing in Ruby on Rails*

Here I&#8217;m specifically referring to expensive tasks that &#8216;lock up the browser&#8217; without any real reason at all. I can probably build a list from here to the moon based on the experiences of others and myself, but I won&#8217;t. Simple examples will suffice, and these include sending mails, resizing images, interacting with other services (RSS, REST) and cron-like processing. Just like I said in the opening statements, the expectations on today&#8217;s websites are enormous&#8230;

*Distributed processing with Ruby*

Leveraging cloud computing to perform an array of expensive or time consuming tasks. This is a wide open description, but I&#8217;d like to restrict the scope to tasks like video encoding, photo manipulation, sending newsletters to thousands of users, crawler activities, and other general tasks related to servicing millions of users. I&#8217;m not referring to cracking the human genome, or even solving the Rubik&#8217;s cube in the smallest number of steps. Tasks of those caliber require something much bigger than what my mind can conjure up.

*Cron-like processing of tasks*

The newsletter example above will fit in here too, since we need to determine at a specific time who will receive which newsletters. The trigger to some crawling activities might also be scheduled. I&#8217;ll make the article is more clear, I&#8217;m a but stumped now&#8230;

*Workflow-like systems*

In this artcle I&#8217;ll probably get crucified for not discussing awesome libraries like [ruote][4] and other BPM engines, but will instead focus on using messaging to drive sequential processes through loosely coupled components, building the ecosystem example used earlier in this article.

**For the impatient and the eager**

I&#8217;ll be discussing examples built on top of [DRb][5], [SQS][6], [Jabber (XMPP)][7], [Advanced Messaging and Queueing Protocol (AMQP)][8] and others. I&#8217;ll also be looking at various clients, servers and services that help facilitate message sending, consumption and brokering with Ruby.

Most important of all is not the technology it self, but the lessons learned from using it. These are lessons I learned while getting baptized by fire, or learned from others who show the same scars. I want to help others to not have the same scars, and instead focus on the next generation of problems so I can learn from them again.

**Looking forward**

At the time of writing I have the other articles in some combination of notes, taboo&#8217;s, del.icio.us-ness and draft posts, and am looking forward to completing them eagerly for publishing, hence this appetizer.

Please add the feed to your reader of choice so you can grab them as they are released. I&#8217;d also appreciate some pre-emptive feedback and pointers from people who&#8217;ve wondered down the same path so I can include more info in the coming articles.

 [1]: http://nutrun.com/weblog/distributed-programming-with-jabber-and-eventmachine/
 [2]: http://brainspl.at/articles/2008/06/02/introducing-vertebra
 [3]: http://en.wikipedia.org/wiki/Message
 [4]: http://github.com/jmettraux/ruote
 [5]: http://www.ruby-doc.org/stdlib/libdoc/drb/rdoc/index.html
 [6]: http://sqs.amazonaws.com/
 [7]: http://www.xmpp.org/
 [8]: http://jira.amqp.org/confluence/display/AMQP/About+AMQP
