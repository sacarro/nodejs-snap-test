#! /bin/sh

set -e

# edit this variable to point to your js file
MY_EXECUTABLE=server.js

platform=$(uname -i)
ARCH=

case $platform in
	x86_64)
		ARCH=amd64
		;;
	armv7l)
		ARCH=armhf
		;;
	*)
		echo "unknown platform for snappy-magic: $platform. remember to file a bug or better yet: fix it :)"
		;;
esac

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SNAP_APP_PATH/$ARCH/lib/openssl-1.0.0/engines:$SNAP_APP_PATH/$ARCH/lib"
export NODE_PATH="$SNAP_APP_PATH/$ARCH/node_modules"

cd $SNAP_APP_PATH/
$SNAP_APP_PATH/$ARCH/bin/node $MY_EXECUTABLE
