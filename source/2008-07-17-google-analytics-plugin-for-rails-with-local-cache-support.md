---
id: 43
title: Google Analytics Plugin for Rails with local cache support
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=43
permalink: /2008/07/17/google-analytics-plugin-for-rails-with-local-cache-support/
tags:
  - analytics
  - capistrano
  - rails
disqus_identifier: '43 http://www.opensourcery.co.za/?p=43'
---

Strangely enough this started as a request from Tyler Bird after reviewing my Capistrano presentation. He was interested in learning how I use Capistrano to update external site dependencies, like a local cached copy of the Google Analytics JavaScript files.

Originally all I did was have this task in my Capfile, and hooked it in after the `deploy:symlink` task:

~~~ruby
desc "Update local urchin.js file"
task :update_urchin, :role => :web do
  run "wget -O #{current_path}/public/urchin.js http://www.google-analytics.com/urchin.js"
end
~~~

I then simply changed the configurations of the [Google Analytics][1] plugin to point to local urchin.js file.

Wow, thats simple enough, but what&#8217;s the catch?

Two things bothered me, support for the newer ga.js file, and not having access to Rails&#8217; timestamping of assets for far future caching.

I pointed out to Tyler that I&#8217;m revisiting a lot of things we do with Capistrano and will post them here as I go along. The Analytics issue was one that bothered me constantly, so I set out to correct it.

I made [my own fork of the Google Analytics plugin][2] over at GitHub, and added support for having local copies of both the legacy and new Analytics JavaScript files, complete with Rails timestamping in the mix. I also added a rake task to help out with keeping the files up to date.

So the capistrano task I mentioned earlier would be changed to look like this now:

~~~ruby
desc "Update local Analytics cached files"
task :update_analytics, :role => :web do
  run "cd #{current_path} && rake google_analytics:update RAILS_ENV=#{rails_env}"
end
~~~

Now you can neatly update your cached copies on each deployment.

Please visit the GitHub fork for more information on the plugin itself. I&#8217;ll set up a local project page on this blog tomorrow. The whole excercise was aimed at showing how to use Capistrano for updating external dependencies, although I have to admit it got a little lost in the noise as I carried on.

 [1]: http://github.com/rubaidh/google_analytics
 [2]: http://github.com/kennethkalmer/google_analytics
