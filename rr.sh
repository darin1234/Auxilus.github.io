#!/bin/bash

wget https://Auxilus.github.io/gemfile
while IFS='' read -r line || [[ -n "$line" ]]; do
    gem install $line
done < "gemfile"
