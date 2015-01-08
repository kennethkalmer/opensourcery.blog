---
id: 283
title: Paginating documents with couchrest and will_paginate
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=283
permalink: /2010/02/08/paginating-documents-with-couchrest-and-will_paginate/
tags:
  - couchdb
  - couchrest
  - ruby
  - will_paginate
disqus_identifier: '283 http://www.opensourcery.co.za/?p=283'
---

[CouchDB][1] is hands down my favorite of the NoSQL variants and offers some pretty spectacular features, none of which I will bore you with in this post. I will however jot down how I (fairly easily) achieved pagination with [couchrest][2] & [will_paginate][3] in a fairly large Rails application recently.

John P Wood [discussed some issues][4] they faced with will_paginate and couchrest during the migration of TextMe to CouchDB, but l left out some code to work with. Couchrest itself had some pagination support that got pulled to some extent&#8230; This left me wanting, and wondering, since it was my turn to walk down this path.

CouchDB is a different beast, its aggressive use of indexes means that occasionally you loose some functionality that you&#8217;ve been accustomed to having in other persistence mechanisms, like the number of rows matching a query. Jan Lenhardt explains on the [CouchDB issue tracker in more detail][5], but it boils down that you need a reduce function to calculate the number of rows. Sounds difficult? Not at all!

In my case I had a collection of announcements to deal with, and the announcement archives is a paginating collection of documents. Standard will_paginate stuff, nothing special.

*Those reading in a reader would want to click through to the post to view the embedded gists further down, or view them [directly at Github][6].*

Below is a condensed version of the model from our paginating system:

~~~ruby
class Announcement < CouchRest::ExtendedDocument
  property :announcer
  property :content
  property :recipients, :cast_as => 'Array', :default => []
  property :archived, :default => false, :type => :boolean
  timestamps!

  view_by :announcer_archive,
    :map => "function( doc ) {
      if( doc['couchrest-type'] == 'Announcement' && doc.archived ) {
        emit( [ doc.announcer, doc.created_at ], 1 );
      }
    }",
    :reduce => "function( keys, values, rereduce ) {
      if( rereduce ) {
        return sum( values );
      }
      else {
        return values.length;
      }
    }"

  class << self

    def by_admins( archived = false, options = {} )
      options[:page] ||= 1
      options[:per_page] ||= 25
      view_name = archived ? 'by_announcer_archive' : 'by_announcer'

      WillPaginate::Collection.create( options[:page], options[:per_page] ) do |pager|
        results = paginate(
          options.merge(
            :design_doc => 'Announcement', :view_name => view_name,
            :startkey => ['admin', {}], :endkey => ['admin'],
            :include_docs => true, :descending => true,
            :reduce => false
          )
        )

        pager.replace( results )

        total = view( view_name, :startkey => ['admin'], :endkey => ['admin', {}], :reduce => true, :group_level => 1 )['rows'].pop
        if total
          pager.total_entries = total['value']
        else
          pager.total_entries = 0
        end
      end
    end

  end
end
~~~

I&#8217;ve included only one view and a corresponding class method, as it is enough to proof the principle. Lets dissect.

The map/reduce functions are extremely simplistic, they simply emit the announcer and the date the announcement was created. This allows for easy scoping and ordering of the announcements. The reduce simply counts our returned records. The magic is in the class method that sets up our WillPaginate::Collection with data from our views.

Line 30 creates a new WillPaginate::Collection instance, passing it the page number and total per page as parameters, it gives us back a pager that we can manipulate.

Lines 31 through 38 uses couchrest&#8217;s pagination support to pull out data from our view. The most important things to note here are that the *page* and *per_page* options are sent to the paginator and *we skip the reduce step*.

Once we have our records loaded, we &#8216;replace&#8217;  the pager&#8217;s collection with our results from our view (line 40).

The final step is to determine the total number of documents available to us, and for this we need the reduce function. On line 42 we call the same view, with the same arguments, except for requiring the reduce step to happen. We use the results (lines 43 to 47) to inform the pager (will_paginate&#8217;s pager) how many rows there are in total.

The controller and the views might look something like this:

~~~ruby
class AnnouncementsController < ApplicationController

  def index
    pagination_options = { :page => params[:page], :per_page => params[:per_page] }
    @announcements = Announcement.by_admins( params[:archived], pagination_options )
  end

end
~~~

~~~haml
= will_paginate @announcements
~~~

It worked, and it shows that we don&#8217;t loose as much as we might think when moving away from ActiveRecord and the ton of plugins surrounding it.

Thanks to John for documenting the migration of TextMe, just knowing that it was possible to combine couchrest & will_paginate gave me the push I needed to figure this out.

Disclaimer: This code is extracted &#8220;as is&#8221; from a real life system and might contain idioms/phrases, and even code, that doesn&#8217;t make 100% when viewed in a gist. Please wear your thinking cap when applying this lesson to your own projects.

 [1]: http://couchdb.apache.org/
 [2]: http://github.com/couchrest/couchrest
 [3]: http://github.com/mislav/will_paginate
 [4]: http://johnpwood.net/2009/08/18/couchdb-the-last-mile/
 [5]: https://issues.apache.org/jira/browse/COUCHDB-82
 [6]: http://gist.github.com/298523
