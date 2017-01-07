---
id: 205
title: Capistrano for your daemons
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=205
permalink: /2009/05/26/capistrano-for-your-daemons/
tags:
  - capistrano
  - daemon-kit
disqus_identifier: '205 http://www.opensourcery.co.za/?p=205'
---

Nothing like some possitive feedback to keep you looking after your own projects, and the feedback on[ daemon-kit][1] has been great so far. My TODO list is growing every day with more features that I need, and others need as well. I mostly add features to daemon-kit as I need them right away, for this reason the docs is still lacking and the support site hasn&#8217;t been setup yet.

However, I&#8217;ve setup the following channels for daemon-kit communication (and updated the README):

  * [daemon-kit@googlegroups.com][2]
  * \#daemon-kit on Freenode

I&#8217;ll be doing my best to stay on top of these channels and garner more feedback from the community at large.

Today&#8217;s sprint was one of the very first things I planned, support for [capistrano][3].

When generating a daemon, use the &#8216;-d&#8217; flag to specify which deployer to use. Currently only capistrano is supported, but I&#8217;ve left the door open for anyone willing to add support for [Vlad the Deployer][4].

`$ daemon_kit /path/to/project -d capistrano`

This will leave you with a *Capfile*, which you don&#8217;t need to edit, as well as *config/deploy.rb* and *config/deploy/*.rb*. The environment specific files in* config/deploy* is used by the *capistrano-ext* gem to support multistage deployments for testing your daemons. Shared configuration details go into *config/deploy.rb*. You need the following gems installed to leverage the deployment options:

  * capistrano
  * capistrano-ext

Capistrano is historically built around Rails applications, but I lifted the capistrano &#8216;deploy&#8217; recipe from capistrano-2.5.5 and customized it to fit in with the requirements of daemons. Some steps have been removed, and some added. Here is the tasks available:

~~~
$ cap -T
cap deploy                     # Deploys your project.
cap deploy:check               # Test deployment dependencies.
cap deploy:cleanup             # Clean up old releases.
cap deploy:cold                # Deploys and starts a `cold' application.
cap deploy:copy_configs        # Copies any shared configuration files from :...
cap deploy:get_current_version # Get the current revision of the deployed code
cap deploy:pending             # Displays the commits since your last deploy.
cap deploy:pending:diff        # Displays the `diff' since your last deploy.
cap deploy:restart             # Restarts your application.
cap deploy:rollback            # Rolls back to a previous version and restarts.
cap deploy:rollback:code       # Rolls back to the previously deployed version.
cap deploy:setup               # Prepares one or more servers for deployment.
cap deploy:start               # Start the daemon processes.
cap deploy:stop                # Stop the daemon processes.
cap deploy:symlink             # Updates the symlink to the most recently dep...
cap deploy:update              # Copies your project and updates the symlink.
cap deploy:update_code         # Copies your project to the remote servers.
cap deploy:upload              # Copy files to the currently deployed version.
cap invoke                     # Invoke a single command on the remote servers.
cap multistage:prepare         # Stub out the staging config files.
cap production                 # Set the target stage to `production'.
cap shell                      # Begin an interactive Capistrano session.
cap staging                    # Set the target stage to `staging'.
~~~

Very close to the original recipes. I&#8217;ve still got to clean this up even further, and add some documentation on how to leverage capistrano for daemons, but for the time being this works very well. The recipe can be found in *lib/daemon_kit/deployment/capistrano.rb* if you have the urge to review it.

Heading towards 0.2, here are the main highlights:

  * god & monit config file generation
  * Improved rdoc&#8217;s and supplementary documentation files
  * Finishing off some issues with error handlers
  * Better logging

 [1]: http://github.com/kennethkalmer/daemon-kit/tree/master
 [2]: http://groups.google.com/group/daemon-kit
 [3]: http://www.capify.org
 [4]: http://rubyhitsquad.com/Vlad_the_Deployer.html
