#!/bin/bash

ESC=

RED=$ESC[91m
GREEN=$ESC[92m
YELLOW=$ESC[93m
BLUE=$ESC[94m
MAGENTA=$ESC[95m
CYAN=$ESC[96m
WHITE=$ESC[97m
DEFAULT=$ESC[0m

SCRIPT=`basename $0 .sh`
cd `dirname $0`

say() {
   [[ "$1" != "" ]] && echo $GREEN$SCRIPT: $1$DEFAULT
   [[ "$2" != "" ]] && echo $GREEN$SCRIPT: $2$DEFAULT
   [[ "$3" != "" ]] && echo $GREEN$SCRIPT: $3$DEFAULT
}

die() {
   [[ "$1" != "" ]] && echo $RED$SCRIPT: $1$DEFAULT
   [[ "$2" != "" ]] && echo $RED$SCRIPT: $2$DEFAULT
   [[ "$3" != "" ]] && echo $RED$SCRIPT: $3$DEFAULT
   exit 2
}

DATESTAMP=$(date +'%Y%m%d-%H%M%S')
CONFFILE=$TMP/$SCRIPT.$DATESTAMP.conf
LOGFILE=$TMP/$SCRIPT.$DATESTAMP.log
SLOT=$MSYSTEM.$MACHTYPE.gcc-12.2.0
{

    say "In $PWD . . ." "Creating $CONFFILE . . ."

    rm -rf $PWD/.fate || die "Could not get rid of '.fate' folder"
    mkdir -p $PWD/.fate/fate-suite || die "Cound not create '.fate/fate-suite' folder"

    echo slot=$SLOT  >$CONFFILE
    echo repo=git://git.ffmpeg.org/ffmpeg.git >>$CONFFILE
    echo #fate_recv="ssh -T fate@fate.ffmpeg.org" >> $CONFFILE
    echo workdir=$PWD/.fate >>$CONFFILE
    echo samples=$PWD/.fate/fate-suite/ >>$CONFFILE
    
    say "Building FFMPEG and running FATE . . ."

    tests/fate.sh $CONFFILE || die "Failed to build FFMPEG or run FATE" "See $LOGFILE for details"
    
    say "Finished building FFMPEG and running FATE" "See $LOGFILE for details"

} 2>&1 | tee $LOGFILE
