---
layout: page
title: Sump-Pi
permalink: /projects/sump-pi/
time_period: college
order: 2
---

![The Sump-Pi](/resources/sump-pi/sump-pi.jpg){: style="max-width: 500px; height: auto;"}

Out in the midwest, we must deal with basement flooding.
Should the [sump pump](https://en.wikipedia.org/wiki/Sump_pump) fail, the basement will flood.
However, if a failing sump pump is caught early, the worst can be averted.
With this in mind, I set out to create a simple but effective sump pump monitor using an old Raspberry Pi 1.
I created a simple program that takes a measurement and emails if there is a problem. With notifications turned on for this email address, it's then easy to know when something has gone wrong.

### **Materials:**
* Raspberry Pi 1 Model A
* Power Supply and SD card with [Rasbian](https://www.raspberrypi.org/downloads/raspbian/) installed
* Internet Access for the Pi
* A [breadboard](https://www.amazon.com/Elegoo-EL-CP-003-Breadboard-Solderless-Distribution/dp/B01EV6LJ7G/)
* A [water sensor](https://www.amazon.com/gp/product/B00A1AEJ9M)
* An [ADC converter](http://ww1.microchip.com/downloads/en/DeviceDoc/21295d.pdf)
* Some wood
* Some mounting adhesive such as [Command Strips](https://www.amazon.com/Command-Refill-Strips-Medium-9-Strips/dp/B0014CQGW4/) and screws

### **Directions:**

In this project, "->" means to add in a file or access a menu.

First set up the hardware as specified by the documentation. Power the breadboard with the Pi, and use the ADC to interface between the the water sensor (analog) and the Pi (digital). More specific instructions will be added later. 

Then, mount the hardware on something, with the water sensor near the ground. I used blocks of wood and command strips to mount the Pi and sensor.

Next, we move onto software. Make a sump-pi user and give it sudo power
{% highlight sh %}
adduser sump-pi
sudo visudo
-> sump-pi ALL = NOPASSWD : ALL
{% endhighlight %}

Then install wringPi
{% highlight sh %}
sudo apt-get update
sudo apt-get install git-core
git clone git://git.drogon.net/wiringPi
cd wiringPi ./build
{% endhighlight %}

Then write the programs to be run, and put in the sump-pi home directory. [bootup.sh](/resources/sump-pi/bootup.sh) sends a message upon bootup, [status.sh](/resources/sump-pi/status.sh) send a message with the status of the pi, and [sump-pi.c](/resources/sump-pi/sump-pi.c) takes measurements and reports if there is a problem. Make sump-pi.c with the [Makefile](/resources/sump-pi/Makefile).

Enable SSH and SPI
{% highlight sh %}
sudo raspi-config
-> Interfacing Options
--> enable SSH and SPI
{% endhighlight %}

Allow outside mailing
{% highlight sh %}
sudo dpkg-reconfigure exim4-config
-> internet site
-> sump-pi.com
-> <Enter>
-> sump-pi.com
-> <Enter> ...
{% endhighlight %}

Set sump-pi and status.sh to run every few hours
{% highlight sh %}
crontab -e
SHELL=/bin/bash
MAILTO=<your email>
HOME=/home/sump-pi

00 *  * * * /home/sump-pi/sump-pi/sump-pi
00 16 * * * /home/sump-pi/sump-pi/status.sh
{% endhighlight %}

And finally, set bootup.sh to be run on bootup
{% highlight sh %}
sudo vim /etc/rc.local
-> home/sump-pi/sump-pi/bootup.sh
{% endhighlight %}

