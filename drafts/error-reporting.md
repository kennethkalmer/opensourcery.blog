# Error reporting and building hoverboards

October 21st came and went. We still don’t have hoverboards. But all is not lost! We can still embrace hoverboards, at least as a metaphor for having a **frictionless software development lifecycle**.

The hoverboard metaphor came to be as I presented to team at work the idea of a frictionless SDLC.

For me this means removing the friction between the software, the team, and the leadership. An overreaching statement would be that most problems software faces is in fact people problems. One of those problems can be attributed to the fact that business tends to have clear goals, budgets, KPI’s, and a variety of other metrics that can measured.

A lot of _soft_ issues in software doesn’t fit well into these metrics, so they get pushed to the wayside. Testing, refactoring, and general project hygiene tend to suffer because it is difficult to measure.

Also couple the fact that most modern software projects start off using a framework and variety of tools, they appear to move very very quickly. This has the risk of skewing the metrics in favour of business and not giving the software team the opportunity to take control of quality.

I’ve heard, and now seen first-hand, how software teams get held hostage because in the recent past they delivered features at a certain rate, and when the wheels come off nobody understands what is going on. This can be attributed to the lack of communication between the software and its creators, and between the creators and the business. There are simply no metrics.

This can often start a toxic circle of events that isn’t healthy for anyone on the team. Ultimately this leads to the classic rewrite, because, we can now have new tools that make things fast again and we’ll be in the same happy place we were when the project started. And now you have more problems.

There are various ways to combat this, various ways to embrace the wheels falling off, because without wheels you could have a hoverboard under your feet. I prefer this to a jack-knifed truck, in what feels like rush hour traffic.

The path to hoverboards is not without friction itself. In this post specifically I’ll be framing error reporting as a means to remove some friction and enable a team of creators to establish a line of communication that quantifies an aspect of software quality to business.

So, lets start at the beginning…

# Leaving the nest

Truth be told, software is unreliable. No matter our best intentions when creating any software, it ends up behaving in unexpected and wonderful ways once it leaves the nest. Just like any living thing entering the real world, we could not possibly prepare our creation adequately for what lies ahead. The real world is wild, dangerous, and full of unintended interactions and consequences.

So how do we keep an eye on our fledgeling? How do we make sure it is safe and can handle the onslaught of entropy? How can we, as responsible creators, react when our code is struck down by the hardships of production life?

## Give it a lifeline

Giving your software a lifeline so it can “call home” when things go wrong is especially important.

There is a slight nuance to point out here. Although logging is important, I’m not talking about just logging errors and/or exceptions.

I consider good logging as effective as a [RECCO](https://en.wikipedia.org/wiki/RECCO) transmitter in times of emergencies. If nobody on the team knows that there was an avalanche, then nobody will go out to search for these signals to pin point what went wrong.

When I say _give it a lifeline_, I mean give your software a way to notify you immediately. Something instant, something realtime. When you have this more realtime connection with your creations you can quickly react when they are in distress and take the appropriate action.

Coincidentally, with a lifeline you can start responding to issues before any upset customers start calling. By the time a call does get through to you, instead of being surprised you can provide useful feedback and an ETA for a fix, assuming the failure isn’t completely catastrophic.

Just think for a moment how rarely you contact other services when they fail. You retry, and if it doesn’t work you might try again much later or completely abandon using the service altogether. Imagine how bad the failure must be before you’d pick up the phone to contact their support. Turn this around, how many users have you lost before someone picked up the phone?

These lifelines are extremely important, and they can be extended to be a lifeline between software developers and business.

They can also enforce improved software quality over the long run. But how, you may ask…

# Guiding tests

Proactive error reporting & monitoring is a great way to guide which tests your software needs. Guided tests are some of the best tests you could write, and it isn’t always obvious where the guidance comes from.

I’ve seen this a lot recently with developers that are new to testing. There is a real struggle with understanding what makes a good test. I saw first-hand at the recent Global Day of Code Retreat how the participants start asking, at different points in the day, how they would apply this to their own projects at work. 

Scarily a lot of them also asked how to get “buy-in” from their managers. I’ve seen this same concern in other conversations too, and I’m sure anyone familiar with sharing the gospel of testing has encountered the same doubts.

Having a record of a real life issue, a signal from the life line, means you could easily and accurately reconstruct the exact conditions under which the error occurred. This is extremely useful to get started. Crossing the outback is an impossible undertaking, but having a compass and a map turns the impossible into the achievable.

The record of the error doesn’t only guide tests, it guides team decision making, it guides reporting to the leadership of a project. By having quantifiable metrics, the team can apply back pressure to the flow of feature requests and get the time they need to improve the seemingly unmeasurable tasks of testing & refactoring.

These quantifiable metrics should have the intended consequence of leading towards test-driven development. Maybe not in its purest form, but most certainly developers would not like their code to be responsible for these notifications. As they get better at responding to issues, they’ll start recognising problematic patterns in their code and cover them pre-emptively with reasonable tests.

Over time the unpleasantness of these tests will lead to refactoring and improving the design of the code.

I use unpleasantness in the broadest sense of the word here. To me it means in the beginning you’re going to be forced to get to grips with your testing harness, spending a lot of time just getting the first failure. You’ll be faced with a lot of unknown unknowns, but push through. The first tests that emerge would probably be slower integration style tests until you get through a few rounds of refactoring to break down the coupling in your system. 

It is akin to starting your first “couch to 5K”. You have to walk before you can run, and while your getting used to running you’ll be doing a lot of walking in between. At the end of it though, you’ll be fitter, and so will your creations. They’ll grow ready for the onslaught of production life and emerge champions.

And brining home the achievements makes it easier for the leadership to understand what you’re doing to create better software. You can start measuring “personal bests” for your software, and get technical and non-technical folks alike to rally around these numbers. It could be _days since last exception_, or _exceptions are less than 0.1% of all operations_, or anything else that matters to your organisation.

To quote [Peter Drucker](https://en.wikipedia.org/wiki/Peter_Drucker), _”What gets measured gets managed”_.

# Resist the temptation to roll your own

As developers we might be tempted to solve the problem by wrapping our code in a `try/catch` block and sending ourselves an email.

On small systems with low traffic this might work, but this is hardly a solution.

Sending email is slow, so not only did your user encounter an error, they have to wait for the email to be sent before you can display them the dreaded _oops, something went wrong_ page. You could delegate this task to a thread, opening up more potential failures.

Secondly, what if your email service is unavailable or misconfigured? Your lifeline could be broken, or the message could end up in spam! Hardly ideal.

Lastly, good reporting. It is hardly a trivial task to do any kind of reporting or aggregations from a mailbox. Over time you’d want to know which errors occurred more frequently so you could help your software face its most daunting challengers first. You also want to know about regressions, just in case you didn’t cover all the possible permutations of the previously painful encounter.

# Enter error reporting services

This market has been steadily growing over the years, with both hosted services and open-source alternatives vying for the attention of your creations.

After I was drowned out by emails generated by the [exception_notification](https://github.com/smartinez87/exception_notification) plugin in my first Rails applications, I switched to [Airbrake](https://www.airbrake.io) (then named Hoptoad). This was a spectacular win for me and my team at the time. The Airbrake client collected a huge amount of additional context for us, including things like the user’s ID from the session. That meant we could proactively reach out to the client about the error they experienced. We could also see how frequently errors occurred, reoccurred, and when we had regressions.

At some point the free plan disappeared and I went looking for alternatives. I’ve since found, and fallen in love with, [Sentry](http://getsentry.com).

## Sentry

Sentry has a great set of features, and is quite simple to deploy locally. They also offer a commercial service, which I’ve never used before.

As far as a self-hosted Sentry goes, I’ve been deploying it with Docker lately. One instance with [fleet on CoreOS](https://coreos.com/using-coreos/clustering/) and another with [Kubernetes](http://www.kubernetes.io). Using the official [Sentry container](http://hub.docker.com/_/sentry) is a breeze, and they detail all the dependencies you need to get going. I’ve tried installing it on Heroku, but this felt like a hack and a little dishonest for my taste. I also know now that a regular dyno is not qualified to run Sentry.

Sentry ticks the most important boxes for me when it comes to error reporting. It has good notification plugins, so apart from  email we get notified right in Slack. All manner of other integrations are also possible, including HipChat, Trello, Pivotal Tracker.

So with the reporting and notification services provided, how do you get about sending errors to Sentry?

## Raven

The Sentry clients are aptly called Raven. Most of the Raven clients have the same baseline features:

* Capture a message
* Capture an exception
* Capture an exception with a richer context

Some clients really tap deep into the applications which contain them. The [sentry-raven](https://rubygems.org/gem/sentry-raven) Ruby gem for instance will extract all the session and parameters and include them with the error reports. The [raven](https://grails.org/plugins/raven) Grails plugin does something similar, and also includes a log4j appender which will report entries at certain log-levels to Sentry by default.

There is fairly good support for handling JavaScript errors too, just don’t ever attach to to `window.onerror`, you’ll get a lot of noise from broken browser extensions/plugins. It is also recommended by most error reporting services that you keep your JavaScript reporting in a separate project, with different notification thresholds and whitelists of acceptable errors.

Start with whatever the defaults are for the existing Raven plugins that are available to you. Once you have errors flowing through you would then start on not only fixing the issues, but refining the reporting.

Good context is key to converting errors from noise to signal. Different Raven clients have reasonably good defaults, but you’d almost certainly want to enrich the errors. 

Sentry supports tagging at three levels:

* Environment (client level): tag your environment name so you can distinguish production from pre-production
* Thread (block level)
* Event (as part of the capture)

All the tags will get rolled up and combined when capturing a message/exception.

After tagging, you could use a concurrency-safe mechanism for setting a richer context. Most Raven clients will try and provide as much of this as possible to you, and they will expose a simple API so you could add even more data.

A simple example would be to extract some session information, or all of it. From here you could get valuable additional _state_ to reconstruct in your tests. You could also find out which user triggered the exception and proactively reach out to them. Another example would be to add some additional context about records loaded from the database. If you’re trapping errors in an API client, the response headers from the remote API could be useful as well.

This is entirely up to you. Start with some noise and work towards distilling the signal from it. A noisy lifeline is better than no lifeline.

## The alternatives

Ever since I used Hoptoad, now Airbrake, a lot of services have cropped up in this space. I’m sure Airbrake wasn’t the first either, but has existed at least since [late 2007](https://github.com/thoughtbot/hoptoad_notifier/commit/34a31064fb9b90c2f97125ac2b2fb6931c26eb77).

There are a lot of exception handling services to choose from. The best is probably to look at what your community is using so you can get some reasonable support beyond what commercial support can provide.

Some performance monitoring services, including New Relic, include error monitoring as part of their performance instrumentation. I’ve never liked that, but it that is just my style.

Beware though in this polyglot age to pick service that only caters to one technology. Even projects like Sentry cannot cover all technologies, but at least they have a [client API](https://docs.getsentry.com/on-premise/clientdev/) you could use to roll your own. Heck, an unofficial client in your own language might just be a great first open source project to start! The docs offer some excellent guidelines for writing your own Raven client, including handling the cases when Sentry itself is unavailable, and performing non-blocking submissions.

A non-exhaustive list I know off, mostly through my days of programming Ruby before I discovered Sentry, include: [Exceptional](https://www.exceptional.io), [Rollbar](http://rollbar.com), [Honeybadger](http://www.honeybadger.io), [TrackJS](https://trackjs.com), [NewRelic](https://newrelic.com), [AppSignal](https://appsignal.com), and of course [Airbrake](https://www.airbrake.io). There will be many more to choose from.

Also consider if you want to roll up performance and exception monitoring in one service, and be careful to not get distracted by the all the shiny graphs and metrics that come with performance monitoring.

Godfrey Chan wrote a great post, [The Log-Normal Reality](http://blog.skylight.io/the-log-normal-reality/) on the Skylight blog recently. I’ll let the post speak for itself as it helps support my bias for separating exception monitoring from performance monitoring.

# Closer to hoverboards

In closing, a good lifeline provides:

* Measurable metrics for improving code quality, reliability and stability
* Metrics that can be used to apply some back pressure to the flow of features and gain valuable time for refactoring
* Can pro-actively reach out to affected customers and mend relationships
* Early warning system for regressions
* Guidance for starting with, or improving existing testing practices

It will only take a few minutes to start experimenting with error reporting and setting up crucial lifelines between you and your creations, so get going!
