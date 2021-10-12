<!--
SPDX-FileCopyrightText: 2021 Alexander 'cblgh' Cobleigh

SPDX-License-Identifier: CC0-1.0
-->

# netsim cookbook
A place to collect various [netsim](https://github.com/ssb-ngi-pointer/netsim) test scripts.

## Guidelines
These guidelines aim to provide recommendations for the test scripts that get added to this
repository:

* Name the test file descriptively (according to what it does or the scenario)
* Use the `comment` command to provide additional context at the top of the test file
    * Optionally: outline the expectations of a successful test run
* Unless important for the test, provide `ssb-server` as the implementation puppets will run in
  the test (keeps scripts uniform)

## License
All test scripts added to this repository are licensed under the MIT license.
