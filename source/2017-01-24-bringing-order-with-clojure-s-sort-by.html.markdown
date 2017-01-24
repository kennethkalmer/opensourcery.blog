---
title: Bringing order with Clojure's sort-by
date: 2017-01-24 17:04 UTC
tags:
- clojure
image: "2017-01-24-bringing-order-with-clojure-s-sort-by/Metal_movable_type.jpg"
---

It is unavoidable, really.

Any data eventually needs to be sorted for presentation. Most of the times we’re very lucky and we could lean on the implicit order of data returned from the database, or we can decorate that HTML table with DataTables and get sorting for free.

Implicit sorting is a crutch that I’ve relied on many times, and I’m sure you have too.

## Implicit sorting in RDBMS systems

What many of us observe when using, say MySQL, is that the rows get returned to us in an order we're familiar with. The insertion order. Using InnoDB tables this generally means ascending by numeric auto-incrementing primary keys. For MyISAM it is strictly insertion order. Other storage engines might have different properties.

Already it is clear that within one RDBMS system we can have multiple behaviours depending on the underlying storage engine used by the table.

Long story short, we have no gaurantees and this can easily nip us in the behind if we're not careful.

## Leaving it to the caller

Knowing now that we cannot depend on the source to sort the data for us, it is almost certainly up to the caller to sort the data. This often comes in the form of a query parameter, be it an `ORDER BY` clause in a SQL statement or a query parameter to an API.

More bespoke sorting tends to happen in the consuming code, not at the source, and this is where we'll look at what Clojure offers us.

# Sorting data with Clojure

Clojure is great at taming data of all kinds, here I just want to explore a few ways to get some order to your data using simple functions.

## Example data

For the examples below I’m going to be working with some invoice data. Each invoice looks something like this:

~~~clojure
{:invoice/number "ACMEINV00001"
 :invoice/date "2016-11-25"
 :invoice/total-before-tax 100
 :invoice/tax 10
 :invoice/items [...]}
~~~

I’ll leave it up to you to imagine how rich these data structures can become in a real invoicing system.

## Getting started with `sort-by`

The first requirement could be to sort a vector of invoices by total. These is relatively simple with `sort-by`:

~~~clojure
(sort-by :invoice/total-before-tax invoices)
~~~

The first argument to `sort-by` should be function, and since keywords are functions of maps you can just specify the key in the map to be used. One caveat, the value of the entry in the map must be comparable.

That gets you a new vector, with the smallest invoices first and the valuable ones at the end. Hardly useful for business, so lets flip it around by supplying a comparator function too:

~~~clojure
(sort-by > :invoice/total-before-tax invoices)
~~~

Now we’re cooking with gas! The most valuable invoices are now at the head of the list! Need the top 10? Just `take` what you need:

~~~clojure
(take 10 (sort-by > :invoice/total-before-tax invoices))
~~~

How did this happen? Clojure compared the values returned by `:invoice/total-before-tax` using the `>` function.

## Sorting by composite keys

The next requirement might be to sort by `:invoice/number` and `:invoice/total-before-tax`. Imagine the idea is that when two invoices have the same total that they are then sorted by their invoice number to show some kind of implied order.

This is where our friend `juxt` comes in. `juxt` accepts a list of functions and returns a new function, that when called, returns the results of all the original functions in a vector.

~~~clojure
(def head-and-tail (juxt first last))
(head-and-tail [1 2 3 4 5]) #=> [1 5]
~~~

Here you can see that juxt applied `first`, and `last`, to the supplied list of numbers and gave us the head and the tail of the list. Keen readers might have just figured out where I’m going with this.

`sort-by` can compare these vectors too, so we can sort our invoices like this:

~~~clojure
(def total-before-tax-and-number (juxt :invoice/total-before-tax :invoice/number))
(sort-by total-before-tax-and-number invoices)
~~~

Now the results will be sorted from lowest value invoice to the highest, with the invoice numbers in order too. So we're halfway there.

## Mixing the order (or composing functions)

The results of the previous example doesn't make much sense. How can we combine sorting the invoice amounts in descending order _and_ have the invoice numbers run sequentially when there is an overlap?

One possible solution is to use `comp`, and make a new function that will return the value of `:invoice/total-before-tax` as a negative number. `comp` works by accepting a list of functions and returning a new function, which when called, calls the arguments from right to left and passing the result of the previous call to the next one, starting with the parameter when called.

An example will be worth a thousand words:

~~~clojure
(require '[clojure.string :as str])
(def up-and-reverse (comp str/reverse str/upper-case))
(up-and-reverse "elloh") #=> "HELLO"

;; or

(str/reverse (str/upper-case "elloh")) => "HELLO"
~~~

In order to get the negative total we can just `comp` together `-` and `:invoice/total-before-tax` like this:

~~~clojure
(def negative-total (comp - :invoice/total-before-tax))
(negative-total invoice) #=> -100
~~~

If this right-to-leftness of `comp` bothers you, you could also simply declare it as an anonymous function which wraps a thread-first functional pipeline: `#(-> % :invoice/total-before-tax -)`.

And using our new friend `juxt` we can simply roll it up like this:

~~~clojure
(def negative-total-and-number (juxt negative-total :invoice/number))
(sort-by negative-total-and-number invoices)
~~~

And now we have a list of invoices sorted by total from most to least valuable, and where the totals match the invoice numbers follow a progression.

Another variation would be to sort by number of items on an invoice. This can be achieved by composing `count` and `:invoice/items` together:

~~~clojure
(sort-by (comp count :invoice/items) > invoices)
~~~

And you'll have the invoice with the most items in at the head of the list.

## Wrapping up

Although my examples are a bit contrived, the power that comes from composing functions in these intuitive ways are nearly endless. This works equally well for predicate functions used by `filter`, `remove` and many others.

It seems many small and composable functions will end up serving you better in the long run!

## Thanks

A big thanks for [Robert Stuttaford](http://www.stuttaford.me/) for helping to [review this post](https://github.com/kennethkalmer/opensourcery.co.za/pull/2)

# References & further reading

* Clojure Docs for [sort-by](http://clojuredocs.org/clojure.core/sort-by), [sort](http://clojuredocs.org/clojure.core/sort), [compare](http://clojuredocs.org/clojure.core/compare), [juxt](http://clojuredocs.org/clojure.core/juxt) & [comp](http://clojuredocs.org/clojure.core/comp).
* [Callability in Clojure](https://camdez.com/blog/2012/03/21/callability-in-clojure/)
* [What is the default order of records for a SELECT statement in MySQL?](http://dba.stackexchange.com/questions/6051/what-is-the-default-order-of-records-for-a-select-statement-in-mysql)


Cover image by [Willi Heidelbach](https://en.wikipedia.org/wiki/Sorting#/media/File:Metal_movable_type.jpg) &mdash; Creative Commons Attribution-Share Alike 3.0 Unported &mdash; Wikipedia
