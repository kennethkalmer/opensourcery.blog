---
title: Pluck out an old revision of a file with git show
author: Kenneth Kalmer
layout: retro
permalink: /2009/03/20/pluck-out-an-old-revision-of-a-file-with-git-show/
tags:
  - git
  - quickies
disqus_identifier: '168 http://www.opensourcery.co.za/?p=168'
---
I was busy merging work back and forth between topic branches today and by accident miss-merged a 700-line spec. Everything else was fine (or so I hope) except this one file. I couldn&#8217;t use *<span style="color: #333333;">git revert</span>*, since that would mean I&#8217;ll have to redo all the merges I made.

So in panic I googled and read several man pages, coming to the following conclusion that worked quite well:

1.  Find the offending commit with *git log* or <em>git log -p</em>, not the revision number prior to the catastrophic change.
2.  View the file at that point in time with <em>git show SHA-ID:path/to/file</em>
3.  Replace current copy with *git show SHA-ID:path/to/file > path/to/file*
4.  Verify the damage has been undone with <em>git diff</em>
5.  Commit
6.  Breathe

Git is a double edged sword, it is extremely powerful and useful, but can be a real pain in the behind. I love git, and will not easily be convinced to move to something else.
