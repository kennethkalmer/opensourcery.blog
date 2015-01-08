---
id: 275
title: Correlating documents in CouchDB
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=275
permalink: /2009/12/13/correlating-documents-in-couchdb/
tags:
  - couchdb
  - ruby
disqus_identifier: '275 http://www.opensourcery.co.za/?p=275'
---

I&#8217;m in the very fortunate position, two actually, of being able to 1) migrate my biggest production application from MySQL to CouchDB, and 2) build a stunning new system for a multinational welfare organization on top of CouchDB.

I&#8217;ve been lurking in the CouchDB world for quite some time and have spent a lot of time wrestling with how to loosely relate documents in CouchDB to each other. A big part of learning to use CouchDB successfully is to break away from the shackles of the relational world. Relationships between documents is one such a shackle that seems hard to break.

It is unavoidable that data has to be correlated, and I wanted to rethink how to do it. After plenty of discussions in #ruote with John Mettraux we came up with a model based on how the web works. Since CouchDB is &#8220;off the web&#8221;, the approach feels quite fitting to me and hopefully to you too.

First some insight into my thinking at this stage.

The web has been successful in loosely expressing relationships between documents. Take two examples:

~~~html
<link rel='stylesheet' href='/foo.css' />
~~~

and

~~~html
<a href='http://www.opensourcery.co.za' rel='magic'>My blog</a>
~~~

*For those of you reading this through a reader, click through to see the gist&#8217;s above.*

Simple as it seems, in both cases we have a document that is somehow related to the page. The nature of the relationship is expressed via the *rel* attribute, and the target specified via the *href* attribute. This got me thinking. Since CouchDB is made *off the web, *can&#8217;t these same principles be applied?

Yes, they can. And here is how:

Currently you might be tempted to express relationships link this in your JSON:

~~~json
{
  "foo_id" : 1,
  "bar_id" : 2
}
~~~

Where changing it to this holds the key:

~~~json
{
  links : [
    { "rel" : "foo", "href" : 1  },
    { "rel" : "bar", "href" : 2  }
  ]
}
~~~

If anything this format, albeit more verbose, expresses the relationships more clearly and in a format that is web friendly. We&#8217;ve broken the shackles of relational thinking.

**Enter Correlate**

<a href="http://github.com/kennethkalmer/correlate" target="_blank">Correlate</a> is an experiment in this line of thinking. It is a mixin for CouchRest&#8217;s extended documents that allows you to express these relationships:

~~~ruby
class SomeDocument < CouchRest::ExtendedDocument

  include Correlate

  related_to do
    some :other_documents, :class => 'OtherDocument', :rel => 'other_document'
  end
end
~~~

Correlate generates getter and setter methods for working with your relationships and lot more (review the <a href="http://github.com/kennethkalmer/correlate/blob/master/README.rdoc" target="_blank">README</a>). It also includes a compatibility layer for ActiveRecord to help when you&#8217;re migrating from ActiveRecord to CouchRest or building a system on CouchDB that needs to access legacy data via ActiveRecord.

The project is still pretty much a moving target, but I&#8217;d love to hear how others address the same issues. Correlate does a great job at maintaining relationship information in a *web friendly* manner and providing you with some convenience around the verbose data structure. Correlate also has a lot of room for improvement, but that will hopefully change over the coming days as I continue integrating it deeply into my existing projects.

Please fork the project on github and join the experiment with me.
