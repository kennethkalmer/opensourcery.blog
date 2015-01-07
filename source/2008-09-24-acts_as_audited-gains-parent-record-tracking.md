---
id: 83
title: acts_as_audited gains parent record tracking
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=83
permalink: /2008/09/24/acts_as_audited-gains-parent-record-tracking/
tags:
  - audits
  - plugins
  - powerdns
disqus_identifier: '83 http://www.opensourcery.co.za/?p=83'
---

As part of our current line of improvements on [PowerDNS on Rails][1], we needed to start auditing changes made through the interface to the DNS data. This is a logical step to opening the system up for more API based interaction, and implementing neat features like macros and temporary authentication tokens.

Auditing in Rails is not for the faint hearted. The Rails Recipes book has an example on how to do this with sweepers, and using the new [ActiveRecord dirty object tracking][2] can help ease the problem too. So after some investigation I found the brilliant [acts\_as\_audited][3] plugin by Brendon Keepers.

After playing with it, I realised one short coming. This is very much a problem specifically for PowerDNS on Rails, but after some thought I realized it could be applied to other auditing challenges as well.

**Enter parent record tracking**

[I forked][4] the [original project][5] on github, and started hacking. Not too long after I came up with this:

~~~ruby
class Author < ActiveRecord::Base
  has_many :books
end

class Book < ActiveRecord::Base
  belongs_to :author
  acts_as_audited :parent => :author
end
~~~

Using the sweepers is also possible, like this:

~~~ruby
class Application < ApplicationController::Base
  audit Author, Book, :parents => { Book => :author }
end
~~~

As contrived as it can be, it allows us to track all the changes to books by a specific author. In the DNS world this allows us to easily access all changes made to the records of a particular domain, and it becomes very valuable. It becomes even more valuable when you need to start tracking deleted records.

Pull requests were sent to the network, hopefully they get accepted and I can remove my repo again.

**Looking forward?**

This was a relatively small step forward for the plugin, but opens a lot of possiblities for the host applications, like PowerDNS on Rails. In any ISP environment audits are extremely important, especially when clients start gaining limited access to the backend systems&#8230;

 [1]: https://github.com/kennethkalmer/powerdns-on-rails
 [2]: http://ryandaigle.com/articles/2008/3/31/what-s-new-in-edge-rails-dirty-objects
 [3]: http://opensoul.org/2006/7/21/acts_as_audited
 [4]: http://github.com/kennethkalmer/acts_as_audited
 [5]: http://github.com/collectiveidea/acts_as_audited
