---
title: Creating an ember-cli addon
date: 2015-03-08 21:18 UTC
tags:
  - ember
  - ember-cli
image: 2015-03-08-creating-an-ember-cli-addon/ember-cli-headline.jpg

---

I've been using [Ember.js][5] for about 15 months at this stage, and I've absolutely loved it. My first Ember project started before ember-cli existed, my second one I built on ember-cli 0.0.17 and up, sometimes spending more time upgrading ember-cli than building out features... That second app never shipped, which was a pity...

It wasn't the last one though, I've since helped build out 4 more Ember applications, all built on ember-cli. It has been an absolute pleasure.

The last one is actually a fork of the first, but I'm converting everything from a horrible grunt-based setup over to the lovely ES6 embrace on ember-cli. In this application I use [nouislider][3] as a customer slider control on Nokia Maps.

I thought it would make a fantastic experiment for shipping as an ember-cli addon. And that is what I set out to do. The whole post below was written in parallel to me actually performing the steps and coding up the component.

In less than 3 hours I had my first ember-cli addon published. Read on to see how!

## Dependencies

I've got ember-cli 0.2.0-beta.1 installed locally, and I'm using node 0.12 for this. I also have bower installed, since it will be pulling in our frontend dependencies.

## Get started

I'm following the [ember-cli documentation on creating add-ons][1] to create this addon.

Firstly generate the addon: _(Be sure to do this outside of an existing ember-cli application!)_

~~~
$ ember addon ember-cli-nouislider
~~~

This will generate quite a complete skeleton for you, including installing all the dependencies you need via npm & bower. Just like Ember itself, ember-cli is very much convention over configuration, and this goes for add-ons too. The result is the generated skeleton addon looks strangely familiar, and I feel quite free and welcome to poke around.

## Publish (aka grab that package)

In a meaningless fit of paranoia about my package name not being available, I just published the blueprint in a land-grab attempt, and it worked...

~~~
$ npm publish
~~~

I'll either figure out how to remove that version, or regret it for a few hours and move on.

## Onto dependencies

The documentation explains more of the different moving parts of an ember-cli addon. I found the parts I needed to add dependencies via Bower and get them hooked into the main application.

Firstly I get the nouislider package installed via bower:

~~~
$ ember install:bower nouislider
~~~

...and move it to the `devDependencies` section of my `bower.json`. This simply configures the dummy app used for development. I also updated the `Brocfile.js` to have this:

Slightly out of order with the addon docs, I now have to make sure I can get my dependencies included into the parent app.

I need to add a blueprint to the addon which will help ember-cli understand there is more to this addon that what meets the eye. So I generate a blueprint with the same name as the project:

~~~
$ ember g blueprint ember-cli-nouislider
~~~

I now have to use the blueprint to install `nouislider` via bower in the main application:

~~~js
// blueprints/ember-cli-nouislider/index.js
module.exports = {
  normalizeEntityName: function() {}, // no-op since we're just adding dependencies

  afterInstall: function(options) {
    return this.addBowerPackageToProject('nouislider'); // is a promise
  }
};
~~~

I also need to hook into the build process, to have the default dependencies included into the vendored JavaScript & CSS.

~~~js
// index.js
module.exports = {
  name: 'ember-cli-nouislider',

  included: function(app) {
    this._super.included(app);

    app.import(app.bowerDirectory + '/nouislider/distribute/jquery.nouislider.all.js');
    app.import(app.bowerDirectory + '/nouislider/distribute/jquery.nouislider.min.css');
  }
};
~~~

That should get the extension going just fine.

## Generating the component

A slight deviation from the documentation, I just generated a new component in the addon project:

~~~
$ ember g component range-slider
~~~

From here I can now build up my component.

The documentation does note that the containing application will need to import your component and re-export it, allowing the consumers of the component to make any modifications if required. I believe this should look something like this:

~~~js
import Ember from 'ember';
import RangeSlider from 'ember-cli-nouislider/components/range-slider';

export default RangeSlider;
~~~

I'm going to skip the details of how I implement the component itself, that could be for another post (let me know in the comments or via Twitter if you'd like to see how).

## Testing the component

Admittedly, testing ember-cli applications is not a skill I've mastered yet. The contributors have really done a spectacular job of making testing a breeze. I added a simple test to ensure the DOM isn't empty when an instance of the component is rendered, I'll have to expand it for testing actions sent from the component.

As for testing with Travis, the generated addon already includes a `.travis.yml` file! This is fantastic.

## Releasing

Releasing means tweaking a few things in the `package.json` file, like setting a proper version, description, checking the license, filling in the repo and author details, and adding some keywords to help with discovery.

The generated README also needs to be modified (and you need to remember those badges!).

Once you're ready, you can just run `npm publish` in the root of the addon. Once npm is done, you can see your new package on [npmjs.com][4].

## Issues along the way

I got bitten by [ember-cli #3413][2] that caused me a bit of pain, but the workaround was easy enough to get going.

## Wrapping up

Done and published. The addon is now available to be installed, and will need to be improved a bit.

This whole exercise took just over 3 hours. In this time I:

* Read the ember-cli docs on generating add-ons
* Ploughed through Github issues related to the issue I mentioned earlier
* Ploughed through the nouislider docs
* Worked through the ember guides on creating components (again)
* Wrote the component, wrote a lousy test
* Got travis configured
* Got the README updated
* Wrote this blog post

Not bad for a Sunday night...

<a href="http://try.hrv.st/6-37348?b" title="Painless time tracking"><img src="https://www.getharvest.com/images/referrals/harvest_banner_130x60.png" height="60" width="130" border="0" alt="Harvest time tracking" /></a>

_PSST: I use Harvest to track my open source work too, so I can keep tabs on that too!_

[1]: http://www.ember-cli.com/#developing-addons-and-blueprints
[2]: https://github.com/ember-cli/ember-cli/issues/3413
[3]: http://refreshless.com/nouislider/
[4]: https://www.npmjs.com/package/ember-cli-nouislider
[5]: http://www.emberjs.com/