---
id: 271
title: VirtualBox, Gentoo and serial consoles
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?p=271
permalink: /2009/09/30/virtualbox-gentoo-and-serial-consoles/
tags:
  - linux
  - quickies
  - serial
disqus_identifier: '271 http://www.opensourcery.co.za/?p=271'
---

More as a reminder to myself for when I need this again, but I&#8217;m sure everyone needs this at least once.

Having screwed up my kernel configs for my VirtualBox Gentoo image, I needed a serial console to catch the boot messages scrolling past in order to see if all the required hardware was being loaded by the kernel. I&#8217;ve never done this on a physical machine before but I am converted now and will acquire a USB to serial port converter in the near future&#8230;

Using <a href="http://www.codestrom.com/wandering/2009/06/opensolaris-virtualbox-ttya-console-debugging.html" target="_blank">this article as a base</a> you need to do the following:

  1. Enable serial ports for your virtual machine
  2. Select &#8220;Host Pipe&#8221;
  3. Enter */tmp/vboxconsole* as the filename
  4. Use netcat to read the console: *nc -U /tmp/vboxconsole*

When booting you need to amend your grub boot line to have the following at the end:

~~~
console=ttyS0,38400
~~~

Making it look something like this:

~~~
kernel=/kernel-2.6.30-r6 root=/dev/sda3 console=ttyS0,38400
~~~

Proceed to boot and look at netcat to see the entire boot output scroll past without disappearing into thin air when the kernel panics.

Man, I love virtualization. I tested this on Mac OS X 10.5 with VirtualBox 3.0.6, but it should work on any *nix platform. Some more [Gentoo serial console madness][1] can be found on the old Gentoo Wiki.

 [1]: http://www.gentoo-wiki.info/HOWTO_Linux_serial_console
