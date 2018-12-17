#!/bin/sh -e
#description=Update IPv6 address.
#foregroundOnly=false
#backgroundOnly=false
#arrayStarted=true
#name=DYNv6 Updater
#argumentDescription=
#argumentDefault=

echo "Start updating IPv6 address..."

hostname=""
token=""
address=$(ip -6 addr list scope global br0 | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)

if [ -z "$address" ]; then
  echo "no IPv6 address found"
  exit 1
fi

echo "Detected address: $address"

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS"
elif [ -e /usr/bin/wget ]; then
  bin="wget -O-"
else
  echo "neither curl nor wget found"
  exit 1
fi

# send addresses to dynv6
$bin "https://ipv6.dynv6.com/api/update?hostname=$hostname&ipv6=$address&token=$token"

echo "Done updating $hostname IPv6 address!"