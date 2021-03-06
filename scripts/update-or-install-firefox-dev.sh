#!/bin/bash

FIREFOX_INSTALL="/opt/firefox-dev/"


curl --progress-bar -Lo firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=fr"

tar -xjf firefox.tar.bz2

rm -rf firefox.tar.bz2

while [ ! -z "$(ps -aux | grep -v grep | grep "$FIREFOX_INSTALL")" ]; do
	read -p "Firefox is running. Retry? "
done

cp -rf firefox/* $FIREFOX_INSTALL || sudo cp -rf firefox/* $FIREFOX_INSTALL

rm -rf firefox/

echo "Done"
