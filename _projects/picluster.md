---
layout: page
title: Raspberry Pi Cluster
permalink: /projects/picluster.html
time_period: college
order: 1
---

[This link](https://pcpartpicker.com/b/R6pG3C) describes the parts and build process of the cluster.

On this page, I will go into technical detail on how to set up the cluster in software This involves formatting and writing the SD card for each node, and then telling them how to communicate on the network. This process is automated [this script](/resources/picluster/flash_script.sh). This script also requires [this file](/resources/picluster/ethernet-static) and [this file](/resources/picluster/netctl@ethernetx2dstatic.service) to be present in the local directory.

Of course with any project, precendent and documentation are extremely useful. I'd like to give credit to the below website for being helpful in this endeavor:

Archlinux, Chromebook, and Raspberry Pi Setup

* [Arch Linux Chrome OS Devices Site](https://wiki.archlinux.org/index.php/Chrome_OS_devices)
* [the C720 Chromebook page](https://wiki.archlinux.org/index.php/Acer_C720_Chromebook)
* [John Lewis's excellent ROM flashing page](https://johnlewis.ie/custom-chromebook-firmware/rom-download/)

Network setup
* [Archlinux Network Configuration](https://wiki.archlinux.org/index.php/Network_configuration)
* [phortx's Raspberry Pi Setup Guide](https://github.com/phortx/Raspberry-Pi-Setup-Guide)
* [Joshua Kiepert Beowulf Cluster](http://coen.boisestate.edu/ece/files/2013/05/Creating.a.Raspberry.Pi-Based.Beowulf.Cluster_v2.pdf)

<!-- * []() -->