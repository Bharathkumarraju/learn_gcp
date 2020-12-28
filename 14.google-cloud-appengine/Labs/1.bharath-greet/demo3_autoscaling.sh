-->sudo apt-get install siege
********************************************************************************
You are running apt-get inside of Cloud Shell. Note that your Cloud Shell
machine is ephemeral and no system-wide change will persist beyond session end.

To suppress this warning, create an empty ~/.cloudshell/no-apt-get-warning file.
The command will automatically proceed in 5 seconds or on any key.

Visit https://cloud.google.com/shell/help for more information.
********************************************************************************
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  siege
0 upgraded, 1 newly installed, 0 to remove and 10 not upgraded.
Need to get 103 kB of archives.
After this operation, 276 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian buster/main amd64 siege amd64 4.0.4-1 [103 kB]
Fetched 103 kB in 0s (6,261 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package siege.
(Reading database ... 131488 files and directories currently installed.)
Preparing to unpack .../siege_4.0.4-1_amd64.deb ...
Unpacking siege (4.0.4-1) ...
Setting up siege (4.0.4-1) ...
Processing triggers for man-db (2.8.5-2) ...
~/bharath_gae_code/bharath-greetings>
-->




~/bharath_gae_code/bharath-greetings>
-->siege -c 250 https://bharathpoc.et.r.appspot.com/
** SIEGE 4.0.4
** Preparing 250 concurrent users for battle.
The server is now under siege...[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable
[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com

[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable
[error] A temporary resolution error for bharathpoc.et.r.appspot.com
: Resource temporarily unavailable

-->

