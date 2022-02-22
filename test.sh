#!/bin/bash
git fetch origin main
if git checkout | grep behind 
then
   echo "drifted"
else
   echo "up to date"
fi
