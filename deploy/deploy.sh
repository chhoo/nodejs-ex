#!/bin/bash
echo "######################"
echo Deploy Process
echo "######################"
pwd
echo "Env =  $1"

#
# check environment to be deployed.
#

if [ "$1" = "test" ]
then
#
# Runtime on server to be deployed
# assume the runtime folder on the test server is as
# 	/c/Users/USER/L1ws/Test/bin"
#
  svr_env="/c/Users/USER/L1ws/Test/bin"
  echo Runtime @ $svr_env
#

#
# stop application server if any
# eg. 
# 
$app_name="notepad"
pid=`ps -ef | grep $app_name | awk '{print $2}'`
echo $pid
kill -9 $pid
#
# load the new binary runtime to the bin folder
#
cp ../bin/* $svr_env

# load config from the config folder
# eg. 
# cp ../config/$1.conf $svr_env/runme.conf

#
# start nodejs application   
cd $svr_env
node login.js &

fi


# #### the end ###

# #
# # mkdir tmp
# # read -p "Press [Enter] key to start Deploy process..."
