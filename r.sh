#!/data/data/com.termux/files/usr/bash

while read p; do
  gem install $p
done < gemdeps
