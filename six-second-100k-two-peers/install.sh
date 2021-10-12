# SPDX-FileCopyrightText: 2021 Andrew 'glyph' Reid
#
# SPDX-License-Identifier: Unlicense

#!/bin/bash

# check for fixtures to avoid redownloading
FIXTURES=100k_100auth_fixtures.tar.gz
if [ ! -f "$FIXTURES" ]; then
    echo "[ downloading the fixtures (test data) ]"
    wget https://people.iola.dk/anders/100k_100auth_fixtures.tar.gz
fi

echo "[ extracting the fixtures ]"
tar -xvzf 100k_100auth_fixtures.tar.gz

# check for care package to avoid redownloading
CARE_PACKAGE=care-package.tar.gz
if [ ! -f "$CARE_PACKAGE" ]; then
    echo "[ downloading the care package (sbot implementations) ]"
    wget https://github.com/ssb-ngi-pointer/netsim/releases/download/v1.0.0/care-package.tar.gz
fi

echo "[ extracting the care package ]"
tar -xvzf care-package.tar.gz --exclude=care-package/ssb-fixtures --strip-components 1

echo "[ copying the ssb-server to the db2 subdirectory ]"
mkdir ssb-server-db2
cp -r ssb-server/* ssb-server-db2/

echo "[ configuring the ssb-server (db) ]"
cp js-js/bin.js ssb-server/bin.js
cp js-js/sim-shim.sh ssb-server/sim-shim.sh
cp js-js/package.json ssb-server/package.json

echo "[ installing the ssb-server (db) ]"
cd ssb-server
npm install
cd ..

echo "[ configuring the ssb-server (db2) ]"
cp js-js-db2/bin.js ssb-server-db2/bin.js
cp js-js-db2/sim-shim.sh ssb-server-db2/sim-shim.sh
cp js-js-db2/package.json ssb-server-db2/package.json

echo "[ installing the ssb-server (db2) ]"
cd ssb-server-db2
npm install
cd ..

echo "[ configuring the go-sbot ]"
cd go-sbot
# uncomment this line if you wish to extract the apple darwin go-sbot build
#tar -xvzf go-sbot/darwin-80b8875.tar.gz go-sbot/ --strip-components 1
# uncomment this line if you wish to extract the linux x64 go-sbot build
tar -xvzf linux-80b8875.tar.gz --strip-components 1
cd ..
cp go-go/sim-shim.sh go-sbot/sim-shim.sh

echo "[ configuration complete ]"
