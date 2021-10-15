# SPDX-FileCopyrightText: 2021 Andrew 'glyph' Reid
#
# SPDX-License-Identifier: Unlicense

#!/usr/bin/env bash

# execute `./install.sh` to configure everything before running simulations

echo "------------------------------"
echo "[ running go-sbot simulation ]"
./netsim run --spec go-go/netsim-test-6s-100k-go.txt --fixtures fixtures-output go-sbot

echo "---------------------------------"
echo "[ running ssb-server simulation ]"
./netsim run --spec js-js/netsim-test-6s-100k-js.txt --fixtures fixtures-output ssb-server

echo "---------------------------------------"
echo "[ running ssb-server (db2) simulation ]"
./netsim run --spec js-js-db2/netsim-test-6s-100k-js-db2.txt --fixtures fixtures-output ssb-server-db2

echo "------------------------------"
echo "[ running server:go-sbot peer:js-db2 simulation ]"
./netsim run --spec go-jsdb2/spec.txt --fixtures fixtures-output go-sbot ssb-server-db2

echo "------------------------------"
echo "[ running peer:go-sbot server:js-db2 simulation ]"
./netsim run --spec jsdb2-go/spec.txt --fixtures fixtures-output go-sbot ssb-server-db2

echo "----------------------------"
echo "[ simulation runs complete ]"
