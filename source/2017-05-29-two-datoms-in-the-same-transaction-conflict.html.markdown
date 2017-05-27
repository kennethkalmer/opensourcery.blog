---
title: "Demystifying Datomic 'Two datoms in the same transaction conflict' errors"
date: 2017-05-29 08:00 SAST
tags:
- clojure
- datomic
image: 2017-05-29-two-datoms-in-the-same-transaction-conflict/colliding_atoms_1_0_by_shinigamisama19-d5ytuyh.jpg
---

I love Datomic, absolutely love it. I simply can't imagine a world without it anymore. I can now relate to how the NoSQL crowd felt a decade ago when they were unshackled from relational databases, except this time I feel the technology has really nailed it. Enough with the anecdotes!

When Datomic transactions fail, the errors can sometimes be very cryptic. Poor error messages are a recurring theme in Clojureland, and my hope is this post helps clarify an error that took me some time to solve. It took some time because my head was somewhere else when it occurred, I was thinking about my system and not Datomic. I was simply trying to transact some data, and it blew up spectacularly. This is what I learned in anger.

## Welcome to the Unseen Gym

Discworld has a new entrant in the personal fitness space, the Unseen Gym. You're tasked with building the membership system. Datomic's treatment of datoms is respectfully similar to your understanding of [Resons](https://wiki.lspace.org/mediawiki/Resons), so it will be a good fit. Your team agrees and you're off to the races.

You start with a basic schema to capture member details:

~~~clj
{:db/ident       :being/given-name
 :db/valueType   :db.type/string
 :db/doc         "Given name of a being"
 :db/cardinality :db.cardinality/one}

{:db/ident       :being/family-name
 :db/valueType   :db.type/string
 :db/doc         "Family name of a being"
 :db/cardinality :db.cardinality/one}

{:db/ident       :membership/number
 :db/valueType   :db.type/long
 :db/doc         "Membership number"
 :db/unique      :db.unique/identity
 :db/index       true
 :db/cardinality :db.cardinality/one}
~~~

It took a long time just to model those attributes, and you're happy with the start. Given the variety of Discworld occupants, it is really hard getting specific with namespaces like `:person/`, since **DEATH** might join too. At least now you can identify a member by a number and some (hopefully pronounceable) name.

There is a lot more to your schema, you might even have partitions in other dimensions. Datomic is keeping it all together.

## First deviation

One of the sales folk decide that Cohen deserves a special rate at the gym. His membership attracts other heros-to-be, but also requires extra ointment to be purchased and kept on a dedicated shelf. You're not sure if he'll end up paying more, or less, but that doesn't matter. You need to be able to set a custom membership fee! And like most changes, it needs to happen right now since word is that Cohen is on his way to the city.

You decide having an attribute that would overwrite the basic membership price is the way to go, and in haste you copy & paste the following forms into your schema and make some small adjustments:

~~~clj
{:db/ident       :membership/set-fee
 :db/valueType   :db.type/long
 :db/doc         "Set fee for this member"
 :db/unique      :db.unique/identity
 :db/cardinality :db.cardinality/one}

{:db/ident       :membership/set-fee-justification
 :db/valueType   :db.type/string
 :db/doc         "Justification for the set fee of this member"
 :db/cardinality :db.cardinality/one}
~~~

And you set off to test:

~~~clj
user=> (def heros [{:being/given-name   "Cohen",
                    :membership/number  6
                    :membership/set-fee 20
                    :membership/set-fee-justification
                    "Marketing & ointment"}
                   {:being/given-name  "Havelock"
                    :being/family-name "Vetinari"
                    :membership/number  7
                    :membership/set-fee 0
                    :membership/set-fee-justification
                    "Not visibly present, ever"}])
'user/heros
user=> (<!! (client/transact conn {:tx-data heros}))
{:db-before {:database-id "59293380-3347-4675-be0a-7daa6286b41c",
             :t 1002,
             :next-t 1003,
             :history false},
 :db-after  {:database-id "59293380-3347-4675-be0a-7daa6286b41c",
             :t 1003,
             :next-t 1006, 
             :history false},
 :tx-data   [#datom[13194139534315 50 #inst "2017-05-27T08:12:08.248-00:00" 13194139534315 true]
             #datom[17592186045420 63 "Conan" 13194139534315 true] 
             #datom[17592186045420 65 6 13194139534315 true] #datom[17592186045420 66 20 13194139534315 true] 
             #datom[17592186045420 68 "Marketing & ointment" 13194139534315 true]
             #datom[17592186045421 63 "Havelock" 13194139534315 true] 
             #datom[17592186045421 64 "Vetinari" 13194139534315 true] #datom[17592186045421 66 0 13194139534315 true] 
             #datom[17592186045421 68 "Not visibly present, ever" 13194139534315 true]], 
 :tempids    {-9223301668109598136 17592186045420, -9223301668109598135 17592186045421}}
~~~

It worked as expected. But just like Lord Vetinari, there is a stealthy bug that will bite us later...

An enthusiastic sales person signs up all the wizards of the Unseen University and a fixed rate of 10. It is almost a given they'll never show up, but you need to import the data quickly:

~~~clj
user=> (def wizards [{:being/given-name "Alberto"
                      :being/family-name "Malich"
                      :membership/number 10
                      :membership/set-fee 10
                      :membership/set-fee-justification 
                      "Wizard discount"}
                     {:being/given-name "Galder"
                      :being/family-name "Weatherwax"
                      :membership/number 11
                      :membership/set-fee 10
                      :membership/set-fee-justification 
                      "Wizard discount"}])
'user/wizards
user=> (<!! (client/transact conn {:tx-data wizards}))
{:datomic.client-spi/request-id "4c69f404-07a4-4c99-bdbb-4596c97ec1f1",
 :cognitect.anomalies/category :cognitect.anomalies/incorrect,
 :cognitect.anomalies/message ":db.error/datoms-conflict Two datoms in the same transaction conflict\n{:d1 [17592186045418 :being/given-name \"Alberto\" 13194139534313 true],\n :d2 [17592186045418 :being/given-name \"Galder\" 13194139534313 true]}\n",
 :dbs [{:database-id "59293380-3347-4675-be0a-7daa6286b41c", 
        :t 1006, 
        :next-t 1007, 
        :history false}]}
~~~

Hidden in there is the following exception:

~~~clj
:db.error/datoms-conflict Two datoms in the same transaction conflict
{:d1 [17592186045418 :being/given-name \"Alberto\" 13194139534313 true],
 :d2 [17592186045418 :being/given-name \"Galder\" 13194139534313 true]}
~~~

Definitely not what we expected, we have no constraints on `:being/given-name`, so what is actually going here? We're not wizards, so we wouldn't notice if there is any sparks of octarine in the air...

Turns out in our earlier haste that we accidentally left the `:db.unique/identity` constraint on `:membership/set-fee`. So what is actually happening here?

It is the first time Datomic is seeing a `:membership/set-fee` value of `10`, so it rightfully prepares to create a new entity using this identifier. But we're giving it two different values for the `:being/given-name` attribute in the same transaction, and that is the conflict it is complaining about.

It is completely non-obvious, especially when encountered in anger. The attribute responsible for the conflict is simply not there, the only thing that hints to it is the duplicate entity id in the datoms.

Luckily this is easy enough to fix, we'll just drop the incorrect unique constraint from the schema:

~~~clj
user=> (def alter-schema [[:db/retract :membership/set-fee :db/unique :db.unique/identity]
                          [:db/add :db.part/db :db.alter/attribute :membership/set-fee]])
'user/alter-schema
user=> (<!! (client/transact {:tx-data alter-schema}))
{:db-before {...},
 :db-after {...},
 :tx-data [...],
 :tempids {}}
~~~

And transact again:

~~~clj
user=> (<!! (client/transact conn {:tx-data wizards}))
{:db-before {:database-id "59294074-9a48-4604-9014-c0c615d32699",
             :t 1001, 
             :next-t 1002, 
             :history false}, 
 :db-after  {:database-id "59294074-9a48-4604-9014-c0c615d32699",
             :t 1002, 
             :next-t 1005, 
             :history false}, 
 :tx-data   [#datom[13194139534314 50 #inst "2017-05-27T10:51:49.395-00:00" 13194139534314 true] 
             #datom[17592186045419 63 "Alberto" 13194139534314 true] 
             #datom[17592186045419 64 "Malich" 13194139534314 true] 
             #datom[17592186045419 65 10 13194139534314 true] 
             #datom[17592186045419 66 10 13194139534314 true] 
             #datom[17592186045419 67 "Wizard discount" 13194139534314 true] 
             #datom[17592186045420 63 "Galder" 13194139534314 true] 
             #datom[17592186045420 64 "Weatherwax" 13194139534314 true] 
             #datom[17592186045420 65 11 13194139534314 true] 
             #datom[17592186045420 66 10 13194139534314 true] 
             #datom[17592186045420 67 "Wizard discount" 13194139534314 true]],
 :tempids   {-9223301668109598135 17592186045419, -9223301668109598134 17592186045420}}
~~~

No octarine sparks, and no signs of the wizards. I doubt they'll ever come to the Unseen Gym...

### Some irony

An aside, if you had a `:db.unique/value` constraint set, instead of `:db.unique/identity`, you would have received the following helpful exception indicating the problem more clearly:

~~~
:db.error/datoms-conflict Two datoms in the same transaction conflict
{:d1 [17592186045424 :membership/set-fee 10 13194139534319 true],
 :d2 [17592186045425 :membership/set-fee 10 13194139534319 true]}
~~~

Trust me while writing this post I got the above exception and had to spend some time to figure out why it wasn't the original exception I noted for this post. Things are seldom as they appear here on the Disc...

## References

This was all done with Datomic Pro 0.9.5561 using the bundled repl. Following the official quick start docs means you could run all of the code snippets in the repl and see the effects for yourself.

* Datomic [getting started docs](http://docs.datomic.com/getting-started/brief-overview.html)
* [Identity and uniqueness](http://docs.datomic.com/identity.html) in Datomic
* [Discworld](https://en.wikipedia.org/wiki/Discworld) by Terry Pratchett

### Cover image

[Colliding Atoms 1.0](http://shinigamisama19.deviantart.com/art/Colliding-Atoms-1-0-360830969) by Shinigamisama19
