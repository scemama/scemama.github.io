=======
Linux
=======

SSH
====

Connect through a gateway
-------------------------

.ssh/config:

.. code-block:: text

  Host target.host.domain target
    User          username_on_target
    HostName      target.host.domain
    ProxyCommand  ssh username_on_gateway@gateway.host.domain nc %h %p 

Setup a reverse tunnel
----------------------

.. code-block:: bash

  user@home $ ssh -R 10000:localhost:22 target.machine.org
  user@target.machine.org $ ssh -p 10000 localhost     # ssh to the home machine

Network
=======

Change dynamically MAC address
------------------------------

.. code-block:: bash

   ifconfig eth0 down
   ifconfig eth0 hw ether 00:90:27:3b:ef:ce
   ifconfig eth0 up

Fix wireless problems when on battery
-------------------------------------

/etc/pm/power.d/wireless::

  #!/bin/sh
  /sbin/iwconfig/ wlan0 power off

Turn on manually interface
--------------------------

.. code-block:: bash

  echo on > /sys/devices/pci0000\:00/0000\:00\:19.0/power/control


GlusterFS
=========

Setup a master
---------------

* Install packages `glusterfs-common` `glusterfs-client` `glusterfs-common`
* Open firewall ports 111, 24007, 24008, 24009-(24009 + number of bricks across all volumes)
* Start the gluster daemon

.. code-block:: bash

  $ glusterd

* Create a volume on the 1st server

.. code-block:: bash

  $ gluster volume create shared_volume lpqlx139:/home/gluster
  Creation of volume shared_volume has been successful. Please start the volume to access data.

* Start the volume

.. code-block:: bash

  $ gluster volume start shared_volume
  Starting volume shared_volume has been successful

* Mount the volume

.. code-block:: bash

  $ mount -t glusterfs localhost:/shared_volum /mnt


* Check the if the volume is OK

.. code-block:: bash

  $ gluster volume info

  Volume Name: shared_volume
  Type: Distribute
  Volume ID: 4ba82dfc-781b-41b0-a201-5bdb8ce2026b
  Status: Started
  Number of Bricks: 1
  Transport-type: tcp
  Bricks:
  Brick1: lpqlx139:/home/gluster

* Allow access to the shared volume only to some machines

.. code-block:: bash

  $ gluster volume set shared_volume auth.allow 130.120.229.31
  Set volume successful


Setup a client
---------------

* Install packages `glusterfs-client` `glusterfs-common`
* Mount the volume

.. code-block:: bash

  $ mount.glusterfs lpqlx139:/home/gluster /mnt


Setup a mirrored server
-------------------------

* Declare storage pools

.. code-block:: bash

  # On lpqlx139:
  $ gluster peer probe lpqsv11
  Probe successful

  # On lpqxv11
  $ gluster peer probe lpqlx139
  Probe successful
  
* Create the volume

.. code-block:: bash

  $ gluster volume create shared_volume replica 2 transport tcp lpqlx139:/data lpqsv11:/data
  Creation of volume testvol has been successful. Please start the volume to access data.

Setup screen for multi-user
===========================

Set the setuid bit on the executable

.. code-block:: bash

  $ sudo chmod u+s /usr/bin/screen
  $ ls -l /usr/bin/screen
  -rwsr-xr-x 1 root screen 360952 Jan 18 2038 /usr/bin/screen

Update your .screenrc

.. code-block:: text

  multiuser on
  acladd bgates,lellison,gvanrossum,dknuth,dnorman

User 1 starts a screen session

.. code-block:: bash

  user1@localhost $ screen 

User 2 connects to the screen

.. code-block:: bash

  user1@localhost $ screen -r user1/

  
  
GPG
===

Add to ~/.gnupg/gpg.conf::

  cipher-algo AES256

Encrypt a file::

  gpg -c ${FILE}

Decrypt a file::

  gpg ${FILE}

Decrypt a file to stdout:: 

  gpg -qd ${FILE}

  
Change keyboard layout in X
===========================

Switch between US and US_intl

.. code-block:: bash

  #!/bin/bash                                                                                                                           
  declare -A new_layout
  new_layout["us"]="us_intl"
  new_layout["us_intl"]="us"
  
  cur_layout=$(setxkbmap -query | grep layout | cut -c13-)
  setxkbmap -layout ${new_layout[$cur_layout]}


IPMI
====

Chassis status::

  $ /usr/bin/ipmitool -I lan -U root -H $HOSTMANE  -P $PASSWORD chassis status

Console redirection::

  $ /usr/bin/ipmitool -I lanplus -U root -H $HOSTNAME -P $PASSWORD -e @ sol activate


Install GNU-Parallel
====================

.. code-block:: bash

  #!/bin/bash
  
  BIN=~/bin
  
  wget "http://mirror.ibcp.fr/pub/gnu/parallel/parallel-latest.tar.bz2"
  tar -xjvf parallel-latest.tar.bz2
  cd parallel-20*/
  ./configure
  make
  cp $(find src -executable | grep '/' ) $BIN


Seafile
=======

init::

  seaf-cli init [-c <config-dir>] -d <parent-dir>

start::

  seaf-cli start [-c <config-dir>]

stop::

  seaf-cli stop [-c <config-dir>]

Download::

  seaf-cli download -l <library-id> -s <seahub-server-url> -d <parent-directory> -u <username> -p <password>

sync::

  seaf-cli sync -l <library-id> -s <seahub-server-url> -d <existing-folder> -u <username> -p <password>

desync::

  seaf-cli desync -d <existing-folder>

create::

  seaf-cli create -s <seahub-server-url> -n <library-name> -u <username> -p <password> -t <description> [-e <library-password>]


Fetchmail
=========

~/.fetchmailrc

.. code-block:: bash

  set daemon 60
  set syslog

  poll pop.gmail.com protocol POP3
     user "recent:xxxx@gmail.com" there is scemama here
     password 'xxxx'
     keep
     ssl


check_mail.sh

.. code-block:: bash

  mailx -H
  echo > $MAIL

