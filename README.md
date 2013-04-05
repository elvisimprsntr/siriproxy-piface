siriproxy-piface
================

About
-----

Siriproxy-piface is a [SiriProxy] (https://github.com/plamoni/SiriProxy) plugin to interface with the [PiFace Digital](http://www.farnell.com/datasheets/1682890.pdf) expansion board for the [Raspverry Pi](http://www.raspberrypi.org).   It does not require a jailbreak, nor do I endorse doing so.

First, you must have SiriProxy installed and working.  [HOW-TOs for SiriProxy] (https://github.com/plamoni/SiriProxy/wiki/Installation-How-Tos) 

Second, you need a [PiFace Digital Interface Board](http://www.farnell.com/datasheets/1682890.pdf) and a [Raspberry Pi](http://www.raspberrypi.org)  

Optionally, you can configure siriproxy-piface to push IP camera images to Siri.

I used my RPi and PiFace board, along with SiriProry as a simple voice controlled garage door opener.   This plugin provides instructions and a basic shell for you to modify for your specific interests.  

I have received offers to make a donation to help offset the cost of hardware and for my time.  If you feel so inclined you can donate thru PayPal.  

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=SB6A4AFSC5LFQ)  


Raspberry Pi and PiFace Digital Interface
-----------------------------------------

The Raspberry Pi is an ARM based single board computer with a number of inputs and outputs, which can be used to interface with the real world.

The PiFace Digital Interface Board has 8 digital inputs, 8 open collector outputs, 2 relays, 4 switches.  

Public Safety and Liability Warning
-----------------------------------

Please do not ask me how to wire up various devices to the Piface board since: 

- That is beyond the scope of this plugin. 
- You need to consider the potential personal injury and property damage liability for using a RPi and PiFace in ways inconsistent with [National Fire Protection Agency (NFPA) - National Electric Code (NEC)](http://www.nfpa.org), local building codes, and your insurance policy.  If your insurance company discovered your [Rube Goldberg](http://en.wikipedia.org/wiki/Rube_Goldberg) contraption was the cause of personal injury or property damage, you could be found liable or negligent in a court of law.   


Installation (New for SiriProxy 0.5.0+)
---------------------------------------


- Manually load the SPI driver

`modprobe spi-bcm2708`

- Permanently enable the SPI driver by commenting out the SPI module blacklist line.

`vim /etc/modprobe.d/raspi-blacklist.conf`

- Install the [C PiFace library dependancies](https://github.com/thomasmacpherson/piface) 

`apt-get install automake libtool`

`git clone https://github.com/thomasmacpherson/piface.git`

`cd piface/c/`

`./autogen.sh && ./configure && make && sudo make install`
 
- Create a plugins directory  

`mkdir ~/plugins`  

`cd ~/plugins/` 

- Get the latest repo   

`git clone git://github.com/elvisimprsntr/siriproxy-piface`

- Add the example configuration to the master `config.yml` 

`cat siriproxy-piface/config-info.yml >> ~/.siriproxy/config.yml`

- Edit the `config.yml` as required.     **Note: Make sure to line up the column spacing.**

`vim ~/.siriproxy/config.yml`

- Edit the piface-ioconfig.yml file to define your PiFace IO. **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-piface/lib/piface-ioconfig.yml`

- Edit the plugin as you wish. **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-piface/lib/siriproxy-piface.rb`

- Bundle.  

`siriproxy bundle`

- Run (Ref: https://github.com/plamoni/SiriProxy#set-up-instructions)  

`[rvmsudo] siriproxy server [-d ###.###.###.###] [-u username]`


Usage
-----

**Open|close garage**

- Siri will push an image from your IP camera and check the status of the door.  If the door is already in the requested position, it will let you know.  
- If the garage door is closed it will open without any need for confirmation.
- If the door is open, Siri will ask you to confirm the door is clear before closing the door. Obviously, this was for safety reasons. 


To Do List
----------

If you want to collaborate, review the issues list for things to implement.  Fork, modify, test, and submit a pull request. 

Licensing
---------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).


