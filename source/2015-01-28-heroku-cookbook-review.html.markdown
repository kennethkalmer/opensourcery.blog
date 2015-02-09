---
title: Heroku Cookbook by Mike Coutermarsh
date: 2015-01-28 20:58 UTC
tags:
  - heroku
  - book review
author: Kenneth Kalmer
disqus_identifier: "http://www.opensourcery.co.za/20150128.1"

---

<em>
tl;dr - Get a copy of the excellent [Heroku Cookbook by Mike Coutermarsh](http://bit.ly/1vLijZn) and learn a few tricks about getting the most from your Rails/Rack applications on Heroku
</em>

I've been a closet fan of [Heroku](http://heroku.com) for years now, always being envious of developers who could just `git push` and stroll over to the coffee machine while the magic happens.

In my journey as a Ruby/Rails guy I haven't had many opportunities to work on applications that could even be deployed to Heroku, but instead I cut my teeth on infrastructure that in essence competed with Heroku, a private cloud for a wholesale ISP.

Flash-forward to the last few years, I've been deploying larger apps with complicated dependencies in the same neighbourhood as Heroku, EC2. I never really considered these systems candidates for Heroku, so they weren't designed in anyway to be compatible with Heroku.

## Rise of the internal apps

It hit me like a ton of bricks, I could in fact deploy all our management consoles to Heroku. I've grown very fond of deploying administration features as separate applications whenever possible since using Heroku for them. They keep the apps focused, and this separation is especially useful for keeping the models clean.

Another benefit of these dashboards is that they tend to get accessed by only a few users, and only a few times a day. That makes them great candidates for Heroku's free tier.

## Getting your first dyno up

[Mike Coutermarsh's Heroku Cookbook](http://bit.ly/1vLijZn) starts off at first principles. It does a fantastic job of laying down the basics, so that you too could get up and running quickly. It walks you through the terminology, it gets the toolbelt and git installed, and covers just enough version control to be useful in this context.

Next up, Rails basics. Adding the required gems, getting a Procfile up (who doesn't love foreman?), and using the toolbelt to add a tiny Heroku PostgreSQL database.

If you're curious about deploying node to Heroku, like I was, the subsequent section covers that by helping you deploy your own instance of the awesome Ghost blogging platform.

We're also introduced to the ephemeral filesystem. I learned here that all dynos get cycled every 24 hours! I knew the filesystem was a place to be avoided, but I thought the slate got wiped clean on every push.

## Getting to know the toolbelt

I only ever used the `heroku` command for setting config variables. I knew there were more commands, just never bothered. The book does a stellar job of making the toolbelt the prefered way to interact with Heroku. It does have a few screenshots of the Heroku dashboards here and there, but the main focus is the toolbelt.

## Running staging

I used to think staging on Heroku was a matter of having different remotes, but it turns out it is easier to setup than I thought.

Mike walks us through `heroku fork` (who knew?), securing staging with basic auth, playing with Heroku Labs' Pipeline feature and even getting Travis deploying directly to Heroku.

## Getting serious

After you've worked through the basics and you've gotten comfortable with the doing things the Heroku Way, Mike steps it up in a big way by going through a whole lot of real-life exercises we'd all be doing on production apps at various stages of their lives.

In the next four chapters he demystifies DNS and SSL management with CloudFlare. He walks you through serving static assets with CloudFront, and leveraging the Redis and Memcache add-ons to boost performance of your application.

Unicorn and Puma get fine-tuned to push performance even further, Rubinius gets pulled in to improve concurrency.

Logging, error reporting & custom error pages also get covered really well.

To make sure all the optimization and tuning worked as expected, Mike walks us through load testing applications with Siege, Blitz.io and Load Impact. While this is going on, we're keeping an eye with New Relic or Librato to make sure there are measurable improvements.

## Rising star for your data

I'm actually using a paid Heroku PostgreSQL plan on a project, and it has been fantastic. We launched before AWS had a PostgreSQL offering on RDS. I still have no reason to switch.

In the Heroku Cookbook, Mike really dives into using and administering Heroku Postgres. I'm going to have to go through this chapter a few times to understand exactly what is on offer.

In earlier chapters he also covers improved scaling by using readonly followers and sharding your data.

To me this was definitely the most insightful chapter, and felt like he kept the best for last.

## Your Heroku

I've known for a while that Heroku had a Platform API, but I wasn't too sure what you could do with it. I now realize that this is one of those things that allow you turn Heroku into exactly what you need.

You could tweak all the knobs for your infrastructure programmatically. Probably even from inside the application you deployed... Need to dynamically spin up more worker dynos to crunch an influx of Big Data? This has you covered. This has you covered really well.

## Closing

I was blown away by how nicely Heroku and its ecosystem has grown up. Sure things have been bumpy at times, and those of us that can build our own infrastructure sometimes feel we need to, simple because.

Mike covers all of this really well in easily digestable pieces. If you're curious about rolling apps out to Heroku, or getting more out of your existing apps, [this book](http://bit.ly/1vLijZn) has you covered.

Even if you don't use Heroku Dynos, a lot of this can be applied with relatively minor tweaks to your existing apps.

Thanks Mike, and thanks Packt for the complimentary copies!
