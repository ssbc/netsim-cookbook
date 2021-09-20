# Six Second Replication

This directory contains three sub-directories with identical netsim test configurations: one tests replication between two `go-sbot` peers; one tests replication with two `ssb-server` peers running `ssb-db`; one tests replication with two `ssb-server` peers running `ssb-db2`.

All tests are run against the same fixtures consisting of 100,000 messages from 20 unique authors. Two identities are chosen: one is labelled as `server` and the other as `peer`. The `alloffsets server` netsim command is used to ensure the `server` starts with all 100000 messages. The `peer` is connected to the `server` and a timer is used to measure how many messages are replicated from `server` to `peer` in 6 seconds. A mutual follow is established before connecting the `peer` to the `server` (hence the 10249 message count for `peer` in the test output).

Initial results for this test suite can be viewed [here](https://github.com/ssb-ngi-pointer/netsim-cookbook/issues/2#issuecomment-921696535).

## Prerequisites

You will need the `netsim` binary installed and accessible from the six second replication directory. See the [releases](https://github.com/ssb-ngi-pointer/netsim/releases/tag/v1.0.0) page to download.

## Instructions

**Configure the simulation environment**

This script downloads the fixtures (test data) and care package (ssb implementations) and configures the various implementations for testing.

_Note: You may need to make `install.sh` executable by first running `chmod +x install.sh`._

`./install.sh`

**Run the simulations**

This script executes the go-go, js-js and js-js (db2) simulations. Output is printed to the terminal.

_Note: You may need to make `simulate.sh` executable by first running `chmod +x simulate.sh`._

`./simulate.sh`

You may wish to pipe the simulation output to a file for further inspection and archiving:

`./simulate.sh > simulation_log.txt 2>&1`

## Troubleshooting

See the excellent [netsim README](https://github.com/ssb-ngi-pointer/netsim) for comprehensive documentation.

If any errors occur, run the simulation(s) manually with the `verbose` flag (`-v`) to assist with debugging:

`./netsim run -v --spec js-js-db2/netsim-test-6s-100k-js-db2.txt --fixtures fixtures-output ssb-server-db2`
