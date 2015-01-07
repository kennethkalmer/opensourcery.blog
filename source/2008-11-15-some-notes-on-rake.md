---
id: 134
title: Some notes on Rake
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=134
permalink: /2008/11/15/some-notes-on-rake/
tags:
  - gentoo
  - rake
disqus_identifier: '134 http://www.opensourcery.co.za/?p=134'
---

![Murphy Law](2008-11-15-some-notes-on-rake/la_ley_de_murphy.jpg)

I&#8217;m busy setting up and extensive suite of Rake tasks to manage the building, configuration, customization and deployment of Gentoo Linux onto USB drives.

We&#8217;re busy migrating all our servers (new and current) onto USB for various reasons, which I don&#8217;t want to elude to just yet. If you think I&#8217;m crazy, EngineYard does the same and I&#8217;m sure plenty of other providers do the same thing too&#8230;

I haven&#8217;t really used Rake extensively in the past, but I know how powerful it is and it was a perfect fit for the tasks at hand. Trying to remember a complicated set of command line parameters and the perfect sequence in which they should run is not a joke. Rake to the rescue.

I did pickup on some non-obvious Rake details, well non-obvious to me at least, and thought I&#8217;d share them here.

**Current working directory**

Rake changes the current working directory to that of the Rakefile before running tasks. This might sound obvious, but I discovered it by mistake.

Consider the following directory structure:

~~~
+ tmp
  - Rakefile
  + some
    + nested
      + directory
~~~

Now edit Rakefile to have this:

~~~ruby
task :default do
  sh "pwd"
end
~~~

You should see the top level directory get outputted to the console no matter how deep you go down the rabbit hole:

~~~
~/tmp$ rake
(in /home/kenneth/tmp)
pwd
/home/kenneth/tmp
~/tmp$ cd some/
~/tmp/some$ rake
(in /home/kenneth/tmp)
pwd
/home/kenneth/tmp
~/tmp/some$ cd nested/
~/tmp/some/nested$ rake
(in /home/kenneth/tmp)
pwd
/home/kenneth/tmp
~/tmp/some/nested$ cd directory/
~/tmp/some/nested/directory$ rake
(in /home/kenneth/tmp)
pwd
/home/kenneth/tmp
~~~

I&#8217;ve always noticed the directory getting printed out, but never realized the significance of this since I&#8217;m always in the same directory where the Rakefile resides&#8230;

**Arguments for tasks**

[Farrel Lifson][1] had this eye opener on arguments for tasks, and I used it happily until I refactored a huge tasks into several smaller ones. Below is my failed test case:

~~~ruby
task :no_args do |task,args|
  puts "no_args: " + args.inspect
end

task :args, :foo, :bar, :needs => :no_args do |task,args|
  puts "args: " + args.inspect
end
~~~

Running it yielded this disappointing output:

~~~
~/tmp$ rake args[hello,world]
(in /home/kenneth/tmp)
no_args: {}
args: {:foo=>"hello", :bar=>"world"}
~~~

And then as [Murphy][2] would have it, after I&#8217;ve changed the tasks back to using standard ENV style arguments, I mistyped the initial failed code like this:

~~~ruby
task :no_args, :foo, :bar, :extra do |task,args|
  puts "no_args: " + args.inspect
end

task :args, :foo, :bar, :needs => :no_args do |task,args|
  puts "args: " + args.inspect
end
~~~

And got these results:

~~~
~/tmp$ rake args[hello,there,world]
(in /home/kenneth/tmp)
no_args: {:foo=>"hello", :bar=>"there", :extra=>nil}
args: {:foo=>"hello", :bar=>"there"}
~~~

So there is some hope, but managing arguments in this style for the entire dependency tree would be a nightmare. Anyone have some good suggestions on the latter we can pass on to the Rake team for inclusion?

 [1]: http://www.aimred.com/news/developers/2008/10/16/arguments-for-rake
 [2]: http://en.wikipedia.org/wiki/Murphy%27s_law
