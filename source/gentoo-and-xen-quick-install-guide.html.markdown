---
id: 28
title: Gentoo and Xen Quick Install Guide
author: Kenneth Kalmer
layout: retro
guid: http://www.opensourcery.co.za/?page_id=28
permalink: /gentoo-and-xen-quick-install-guide/
categories:
  - linux
  - postfix
disqus_identifier: '28 http://www.opensourcery.co.za/?p=28'
---

**<span style="color: #800000;">WORK IN PROGRESS &#8211; FIRST DRAFT OF THE PAGE</span>**

This is a quick install guide for getting a <a href="http://www.gentoo.org" target="_blank">Gentoo</a> <a href="http://xen.xensource.com/" target="_blank">Xen</a> host installed and configured on a clean x86 server. You&#8217;ll need to be familiar with both Gentoo and Xen in order to use the guide, it is not a guide for total noobs, sorry&#8230;

We make extensive use of Gentoo throughout our infrastructure, and Xen is a loyal virtualization technology that we cannot live without (whether on our own hardware or on Amazon&#8217;s EC2).

This guide is basically a carbon copy of the <a href="http://www.gentoo.org/doc/en/gentoo-x86-quickinstall.xml" target="_blank">Gentoo Linux x86 Quick Install Guide</a> and the <a href="http://www.gentoo.org/doc/en/xen-guide.xml" target="_blank">Configuring Gentoo with Xen</a> documents, but the steps are mixed together when it comes to installing Xen, the Xen kernel and rebuilding the world.

**Phase 1 &#8211; Getting the install media, setting up partitions and getting the stage and portage on the disk**

Follow the <a href="http://www.gentoo.org/doc/en/gentoo-x86-quickinstall.xml" target="_blank">Quick Install Guide</a> until just before the &#8220;<a href="http://www.gentoo.org/doc/en/gentoo-x86-quickinstall.xml#doc_chap2_sect11" target="_blank">Kernel Configuration</a>&#8221; section. Check out my notes below as well.

*Partition layout*
We use a standard layout on all our servers that looks like this:

~~~
Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1          13      104391   83  Linux
/dev/sda2              14         136      987997+  82  Linux swap / Solaris
/dev/sda3             137        1353     9775552+  83  Linux
/dev/sda4            1354       13275    95763465   8e  Linux LVM
~~~

We give our guest domains logical volumes to use as storage. Using LVM for Xen guest storage simplifies backups, resizing of disks and plenty else. A couple of Google&#8217;s will help you find some more valuable information (I&#8217;ll amend this page in time).

**Phase 2 &#8211; Updating make.conf, rebuilding world, install Xen and the Xen kernel**

The Quick Install Guide takes you through a normal Gentoo kernel install, where the Xen guide takes you through rebuilding the world and getting the Xen kernel/tools installed.

I skip the standard Gentoo kernel and jump directly into the Xen steps here.

*Updating make.conf*

You need to edit /etc/make.conf and add &#8220;<span class="code-input">-mno-tls-direct-seg-refs&#8221; to the CFLAGS, so it looks like this:</span>

~~~
# nano -w /etc/make.conf
~~~

(Add -mno-tls-direct-seg-refs)

~~~
CFLAGS="-O2 -march=pentium4 -pipe -mno-tls-direct-seg-refs"</pre>
~~~

Then, *before you rebuild the world*, make sure your portage snapshot is fully up to date, and then rebuild the world.

~~~
# emerge --sync
# emerge -evat world
~~~

Now everything is optimized for Xen, without the rebuild your Xen performance would be very very poor.

You can then continue the steps in the <a href="http://www.gentoo.org/doc/en/xen-guide.xml" target="_blank">Configuring Gentoo with Xen</a> up and until configuring the guest domains. You can continue that after completing the rest of the Quick Install Guide. Reason? Well, you now skip the Kernel Configuration section in the Quick Install Guide and continue with <a href="http://www.gentoo.org/doc/en/gentoo-x86-quickinstall.xml#doc_chap2_sect12" target="_blank">&#8220;Configuring your system</a>&#8220;. You do need a valid fstab file, grub, and the works.

My only notes on configuring the Xen kernel is that we don&#8217;t split up the build in different locations, we are disciplined :). If you get boot errors (kernel can&#8217;t find the root file system) check for missing SCSI/SATA drivers in the kernel configuration.

**Phase 3 &#8211; Enjoy Gentoo and Xen**

There are plenty of resources available on the net for Gentoo and Xen, and Xen in itself. We&#8217;ve built plenty of Xen servers over the last couple of years, including Debian, CentOS and Gentoo-based hosts. The same rules apply to all of them. Keep your head on and make sure your privileged kernel has the correct drivers.

