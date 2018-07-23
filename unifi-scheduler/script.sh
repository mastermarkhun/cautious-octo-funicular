#!/bin/bash
#description=Scheduled switching for Unifi AP LED.
#foregroundOnly=false
#backgroundOnly=false
#arrayStarted=true
#name=Unifi LED switcher
#argumentDescription=
#argumentDefault=

time=$( date +%H )

if [ $time -ge 22 ] || [ $time -lt 06 ]
then
    bool="false"
else
    bool="true"
fi

echo "time: $time"
echo "bool: $bool"

/usr/bin/expect <<EOD

set timeout 60

spawn ssh <username>@<ip-address>

expect "yes/no" { 
	send "yes\r"
	expect "*?assword" { send "<password>\r" }
	} "*?assword" { send "<password>\r" }

expect "# " { send "echo mgmt.led_enabled=$bool > /var/etc/persistent/cfg/mgmt\r" }
expect "# " { send "save\r" }
interact