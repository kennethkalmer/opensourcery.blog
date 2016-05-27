---
title: Smooth client-side routing in a figwheel-only project
date: 2016-05-27 16:59 UTC
tags:
  - clojure
  - clojurescript
image: 2016-05-27-smooth-client-side-routing-in-a-figwheel-only-project/training-wheels.jpg
---

One of the few things I missed when starting with [re-frame](https://github.com/Day8/re-frame) was the excellent client-side routing setup you get with ember-cli, especially the development server part of that.

After some digging I found this fantastic article, [No-hashes bidirectional routing in re-frame with silk and pushy](https://pupeno.com/2015/08/18/no-hashes-bidirectional-routing-in-re-frame-with-silk-and-pushy/), in which Pablo lays out all the Clojurescript required for nice push state based routing.

In the article though Pablo does note that he hasn't tried setting this up with a figwheel only project. I needed to figure this out for myself, and it turned out that my first journey into the wilderness was not nearly as daunting as I thought.

Browsing through the lein-figwheel docs I found a reference to providing your own [`ring-handler`](https://github.com/bhauman/lein-figwheel#static-file-server).  Looking around further I noticed that Arne Brasseur's [chestnut](https://github.com/plexus/chestnut) provides a custom `ring-handler` for a smoother development experience.

Using these hints I got it working fairly easily!

## Project updates

First off, add the following dependencies to your `project.clj`

~~~clojure
    [ring "1.4.0"]
    [ring/ring-defaults "0.2.0"]
    [compojure "1.5.0"]
~~~

Still in your `project.clj`, add a `:ring-handler` option to the fighweel settings like so:

~~~clojure
    :figwheel {:css-dirs ["resources/public/css"]
               :ring-handler example.dev-server/http-handler}
               ;; ^-- THIS
~~~

Now it is time to create the dev-server, simply open up `src/clj/example/dev_server.clj` (making the parent directories and setting the right namespace) and drop in the following:

~~~clojure
(ns example.dev-server
  (:require [clojure.java.io :as io]
            [compojure.core :refer [ANY defroutes]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(defroutes routes
  (ANY "*" _
    {:status 200
     :headers {"Content-Type" "text/html; charset=utf-8"}
     :body (io/input-stream (io/resource "public/index.html"))}))

(def http-handler
  (-> routes
      (wrap-defaults site-defaults)))
~~~

Basically what this does is turn your `index.html` file into a 404 handler. The dev-server will serve up this file when figwheel can't find static assets in your project.

## Deployment

Just for completeness sake, when deploying your figwheel build you'll need to add something like this to `server` directive in nginx:

~~~nginx
server {
  location / {
    expires -1;

    try_files $uri $uri/ /index.html =404;
  }
}
~~~

That [`try_files`](http://nginx.org/en/docs/http/ngx_http_core_module.html#try_files) directive does the same as our ring middleware. It turns your index.html into a glorified 404 handler.

Beware though to properly do 404 handling in your client-side application when you don't recognize the URL, or if a backend API returns a 404. You don't have nice status codes now, which may or may not matter to your app.

## In closing

I'm sure there are many more ways to get this done, so do some research before just pasting my code in :). For one, maybe setting up the dependencies in the development profile in leiningen instead of a hard dependency for the entire project.

There are many small things like this that makes ember-cli shine. But we can bring those refinements across bit by bit. Then again, figwheel offers an amazing developer experience on its own.

At the moment though I can say I'm very happy with learning Clojure & ClojureScript. There is still so much to learn!

_Image from [REM online](http://www.remonline.com/when-do-the-training-wheels-come-off/)_.
