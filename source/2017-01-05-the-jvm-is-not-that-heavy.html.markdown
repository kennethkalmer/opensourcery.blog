---
title: The JVM is not that heavy
date: 2017-01-05 21:19 UTC
tags:
- jvm
- clojure
image: 2017-01-05-the-jvm-is-not-that-heavy/fine.jpg
---

> Mostly my opposition to Clojure is the JVM. That sh*t is heavy.
 
This came up in the [ZA Tech](http://zatech.co.za) Slack team several weeks ago. While watching some Clojure talks over the holidays the speakers also noted this objection over and over again.

I had a bit of a [monologue in Slack](https://zatech.slack.com/archives/developers/p1481966328001513) about this. Now I'm penning it down for broader consumption and discussion.

## Background

I used to think the JVM was heavy too. This was way back in the early 2000's when I compared it to PHP. There were other heavy alternatives too, like .NET and ColdFusion. There were lighter alternatives like Perl & Python, but I was on Windows back then so ActivePerl and ActivePython were also a bit heavy.

I first got over my "fear" of the JVM when I deployed a little production app with JRuby to Heroku. This little beast only had to perform a single daily task. It generated a bunch of PDF's and then uploaded them to iSign (now defunct) for storage and sharing. iSign itself was a classic Rails app, hosted on 3 AMI's. This little dyno running a stock JVM (except for `-server -Xmx=512M`) produced PDF's so fast that it basically killed the 3 node cluster on every run.

Still I thought it was a bit heavy to use, but I was in love with the ugly duckling.

I've more or less followed JRuby development and success stories, and had a fantastic time at [Rubyfuza 2016](http://rubyfuza.org) with Charles Nutter. I felt so inspired afterwards that I went on a mission to [open pull requests](https://github.com/activeadmin/activeadmin/pull/3792) to Ruby projects that simply runs their tests with JRuby. It stopped with that one, my bad.

## Fast forward to 2016

I tried building a Rails app from scratch in November 2016. It was the first time in months that I attempted any Ruby programming on my machine. A `brew upgrade` bumped rbenv and thus threw away all my Ruby installs and I didn't even notice.

I was going to present on websockets at [Jozi.rb](https://www.meetup.com/joziruby/events/235962465/).

My starting point was to play with the [React on Rails](https://www.reactrails.com) repo just to get a feel for using React with Rails. I've been using [re-frame](https://github.com/Day8/re-frame) for a few months and was confident I can pull it off with raw React.

The wheels came off, spectacularly.

To clone and run one sample app I needed to upgrade XCode, upgrade the command line tools for XCode (>6GB in total), install a new Ruby version and bundler and then bundle install in the sample app... Simple right? The sample app, like the majority of Rails apps, depends on libv8 somewhere in the dependency graph and that alone is more than 1GB in size.

That whole exercise took hours.

Playing with the very impressive demo I realized it was bringing an HCMB to a game of rock-paper-scissors. I decided to build the frontend with Ember instead, since I know Ember and was running out of time.

Same thing again, need to update nvm, install a respectable node version, install ember-cli, generate the app and install the dependencies via npm _and_ bower.

I played a little and gave up, and instead shared this experience with the handful of folks that came. It was humbling, truly humbling. I felt like a stranger in a world I've been part of for so long.

Back to the statement of the JVM being _heavy_.

## How do you weigh it?

* Is it the size of the JDK when you download it?
* Does it use a lot of resources when you run it?
* Do the libraries consume a lot of disk space?
* Is it a ceremonial affair to deploy?
* Does it slow you down in your day to day?

These are some questions that can help cut through our emotional barriers when thinking about the JVM. These emotions, these biases are costly and can hurt us in the long run.

So lets tackle them to see what lies beneath.

## Is the upfront cost really that high?

This _"heaviness"_ of the JVM is pure FUD, and starts with this large-ish upfront cost to installing it. You compare the ~200MB download of the JDK to the ~15MB download of Node or Ruby. That is only the baseline. For both Node and Ruby you need a C compiler on the system which is hundreds of megabytes alone. Even worse, you probably need a compiler in production!

The amount of bloat required with Node and Ruby is hidden away from you with these small incremental steps. If you stop and take stock of it all, not to mention the time you've spent, you'll see the 200MB is way more efficient.

I don't even want to go down the path of assembling your own webpack config, just to have it overthrown when the next new tool arrives.

![https://twitter.com/iamdevloper/status/517616294909464576](2017-01-05-the-jvm-is-not-that-heavy/iamdevloper.png)


## Is running the JVM that heavy?

The JVM is fast, it is probably one of the [fastest runtimes](https://www.techempower.com/benchmarks/#section=data-r13&hw=cl&test=fortune) out there. It just keeps getting faster and leaner with time. Thousands of the smartest engineers are working to make it better, and even more have contributed in the last 21 years.

It has real threads, supports multiple cores, and can be configured to hell and back, or just left alone. The only useful thing you probably need to know is how to set the memory for the JVM so it can works its magic within the constraints of your environment.

Deploying to Heroku? `java -server -Xmx512m beast.jar`. If that doesn't suffice you probably have income and can pay someone for advice... Oh, or StackOverflow.

This is a key thing that Charles and other people in the JRuby community keep pushing. Without you doing anything, your apps will surely get faster and faster with each JVM release (independent of JRuby progress).

## Is disk usage that heavy?

I was curious and looked at my `~/.m2` folder, turns out in 9 months of Clojure development I've only accumulated **1010MB** of dependencies. Not even a gigabyte yet.

~~~
$ du -sh /usr/local/opt/rbenv/versions/2.3.3 ~/.nvm/versions/node/v6.9.1 ~/.m2
690M	/usr/local/opt/rbenv/versions/2.3.3
232M	/Users/kenneth/.nvm/versions/node/v6.9.1
1010M	/Users/kenneth/.m2
~~~

The Ruby install is fresh again, and basically has the requirements for this blog and Middleman (I've been working on a fix there). Yep, to run this static blog and contribute to the tools that power it requires nearly 700MB of storage.

Node only has ember, docpad and bower installed and we're over 200MB.

## Is deploying it that heavy?

You can probably predict where I'm going with this...

Your build step produces a single JAR file. It has everything you need to your app running somewhere else. You simply place the JAR where you need it and let a JVM loose on it.

It is not a requirement that you deploy your applications into some massive application server, you can very easily bundle up a performant HTTP server right in your JAR file. Node folks do, Ruby folks do it, yet somehow JAR files can't stand on their own? I used to think so too...

I, for one, am relieved not to have run `apt-get install build-essentials` on a production box.

## Day to day with the JVM

I run at least **5** JVM processes on my 2012 MacBook Pro with 8GB of memory. This is all day, every day. I would never have tried to start 5 Rails apps at the same time.

Why 5? Two for [Datomic](http://www.datomic.com) (transactor & console), one for our backend API and one for whichever frontend I'm working on. Sometimes I have automated tests running the background too. I'm sure that macOS's memory compression definitely helps here since a good chunk of those JVM processes should have all the same bytes loaded into memory.

![](2017-01-05-the-jvm-is-not-that-heavy/activity-monitor-main.png)
![](2017-01-05-the-jvm-is-not-that-heavy/activity-monitor-java.png)

But if you told me just 10 months ago that I would be doing this I would have laughed you off. Who in their right mind runs **5 or more** JVM processes? I can go on a limb and say I'm definitely not the only one.

Oh, but what about class paths and all these other crazy things? Haven't needed to touch any of those thanks to the great tooling provided by Clojure. It is the same reason you use npm or bundler, so you don't have to fiddle with include paths. You could, but then you probably have a different problem you're not seeing.

### Joys of the REPL

If I had to stop and start the JVM instances continuously I would definitely loose my mind. That bothered me with JRuby a lot back in the day. Luckily with Clojure and the amazing REPL I only need to restart a JVM instance in the rare case that I borked something up badly. It is rather idiot proof. [Figwheel](https://github.com/bhauman/lein-figwheel) runs for days without issues.

## Conclusion

Be very careful before judging the JVM as a target. Judge Java as a language by all means, but keep it separate from the virtual machine.

I used to believe the same things you did. I used to think of the JVM as this behemoth. Now I'm thankful to be able to throw my parentheses at it and have the work of thousands of giants support it.

By no means take this post as a sign of "the end of Node" or "the end of Ruby". Let it bring a fresh perspective. If you can't switch to the JVM, at least think about what you could do to help eliminate the bloat from your own world.

Thanks for giving me the privilege of your time. Now [go learn](http://www.braveclojure.com/) some Clojure, and experience [Simple Made Easy](https://www.infoq.com/presentations/Simple-Made-Easy).
