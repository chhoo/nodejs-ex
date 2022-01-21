#!/bin/bash
echo "######################"
echo " Deploy Process"
echo "######################"
pwd
$Env = $args[0]
echo "Env = $env"
#
# check environment to be deployed.
#

if ( compare-object $env "test" )
{
  echo "not Test env"
}
else
{
#then
#
# Runtime on server to be deployed
# assume the runtime folder on the test server is as
# 	/c/Users/USER/L1ws/Test/bin"
#
  $svr_env="c:\Users\USER\L1ws\Test\bin"
  echo "Runtime @ $svr_env"
#

#
# stop application server if any
# eg. 
# 

forever stop ..\..\..\bin\login.js
forever list
#
# load the new binary runtime to the bin folder
#
cp  ../bin/* $svr_env/ -Recurse -Force

# load config from the config folder
# eg. 
# cp ../config/$1.conf $svr_env/runme.conf

#
# start nodejs application   

forever start ..\..\..\bin\login.js
forever list

}
#fi

# #### the end ###
# # read -p "Press [Enter] key to start Deploy process..."
