---
id: 192
title: 'Quick *nix shadow passwords with Ruby'
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=192
permalink: /2009/05/01/quick-nix-shadow-passwords-with-ruby/
tags:
  - linux
  - shadow
disqus_identifier: '192 http://www.opensourcery.co.za/?p=192'
---

Just thought I&#8217;d share this one to boost the available online information. Using [String#crypt][1] and [*man crypt*][2] you&#8217;ll come up with something similar to the [gist][3] below (extract from a project I&#8217;m busy working on).

~~~ruby
module Linux
  class User
    class << self
      # Generate an MD5 salt string
      def salt
        seeds = ('a'..'z').to_a
        seeds.concat( ('A'..'Z').to_a )
        seeds.concat( (..9).to_a )
        seeds.concat ['/', '.']
        seeds.compact!

        salt_string = '$1$'
        8.times { salt_string << seeds[ rand(seeds.size) ].to_s }

        salt_string
      end

      # Crypt a password suitable for use in shadow files
      def crypt( string )
        string.crypt( self.salt )
      end
    end
  end
end
~~~

And the spec

~~~ruby
require File.dirname(__FILE__) + '/../spec_helper'

describe Linux::User do
  describe "generating shadow passwords" do
    it "should generate a salt for crypt" do
      salt = Linux::User.salt
      salt.length.should be(11)
      salt.should match(/^\$1\$[a-zA-Z0-9\.\/]{8}$/)
    end

    it "should generate a shadow password" do
      pass = Linux::User.crypt( 'secret' )
      pass.should match(/^\$1\$[a-zA-Z0-9\.\/]{8}\$[a-zA-Z0-9\.\/]{22}$/)
      pass.length.should be(34)
    end
  end
end
~~~

*HTH*

 [1]: http://www.ruby-doc.org/core/classes/String.html#M000823
 [2]: http://www.kernel.org/doc/man-pages/online/pages/man3/crypt.3.html
 [3]: http://gist.github.com/104980
