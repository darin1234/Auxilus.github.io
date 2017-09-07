#!/bin/bash

#wget https://Auxilus.github.io/gemfile
while IFS='' read -r line || [[  "$line" ]]; do
    echo "Installing $line \n" 
    #gem install $line
done < "gemdeps"
