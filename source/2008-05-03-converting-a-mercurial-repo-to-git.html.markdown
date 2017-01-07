---
id: 23
title: Converting a mercurial repo to git
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=23
permalink: /2008/05/03/converting-a-mercurial-repo-to-git/
tags:
  - convert
  - git
  - mercurial
  - quickies
disqus_identifier: '23 http://www.opensourcery.co.za/?p=23'
---

Keeping with the exodus from SVN/Mercurial to git, here is a super quick guide for converting a Mercurial repo to git.

1. Get the [fast-export][1] script via git:

    `git clone git://repo.or.cz/fast-export.git`

2. Make a new (empty) git repo for the project that is currently in Mercurial

    `git init projectname.git`

3. Use fast-export to do the convertion

    ```
    $ cd projectname.git
    $ /path/to/fast-export.git/hg-fast-export.sh -r /path/to/project.hg
    git checkout master
    ```

4. (Optionally) use rsync to bring over uncommitted changes

    rsync -av --delete-after --exclude=.git --exclude=.hg /path/to/project.hg /path/to/project.git

5. Enjoy your new git repo :)

I&#8217;ve only followed these steps on projects that are in their infancy, and were used as Mercurial experiments. I&#8217;m not sure how well branches and tags will be handled by the script. Any feedback would be welcome.

 [1]: http://repo.or.cz/w/fast-export.git
