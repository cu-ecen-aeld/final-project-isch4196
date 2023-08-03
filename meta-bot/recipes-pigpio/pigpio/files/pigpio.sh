#!/bin/sh

case "$1" in
    start)
	echo "loading pigpio"
	/usr/bin/pigpiod
	;;
    stop)
	echo "stopping pigpio; do nothing"
	;;
    *)
	echo "Usage: $0 {start|stop}"
	exit 1
esac

exit 0
