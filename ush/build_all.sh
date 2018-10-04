#!/bin/sh

date
#===================================================================#

#
#--- Finding the RTMA ROOT DIRECTORY --- #
#
BASE=`pwd`;
echo " current directory is $BASE "

# detect existence of directory sorc/
i_max=5; i=0;
while [ "$i" -lt "$i_max" ]
do
  let "i=$i+1"
  if [ -d ./sorc ]
  then
    cd ./sorc
    TOP_SORC=`pwd`
    TOP_RTMA=`dirname $(readlink -f .)`
    echo " found sorc/ is under $TOP_RTMA"
    break
  else
    cd ..
  fi
done
if [ "$i" -ge "$i_max" ]
then
  echo ' directory sorc/ could not be found. Abort the task of compilation.'
  exit 1
fi

export USH_DIR=${TOP_RTMA}/ush

#
#--- check out GSI package
#
cd ${USH_DIR}
echo " running checkout_rtma_gsi.sh to check out GSI package...  "
./checkout_rtma_gsi.sh

#
#--- build GSI
#
cd ${USH_DIR}
echo " running build_rtma_gsi.sh to build GSI code ..."
./build_rtma_gsi.sh

#
#--- link exe, fixed data, etc.
#
cd ${USH_DIR}
echo " running link_rtma.sh to link fixed dta , executables, etc. ... "
./link_rtma.sh

#===================================================================#
date

exit