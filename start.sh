#!/bin/sh

killall conky

echo "jumping to target directory"
cd "$(dirname "$0")"

echo "starting conky"
####sleep 1
( set -x; setsid conky -c angle_minus_five_degrees.conf )
####sleep 3

echo "exiting......"
####sleep 2

exit
