// SPDX-FileCopyrightText: 2021 The Secure Scuttlebutt Consortium authors
//
// SPDX-License-Identifier: MIT

#! /usr/bin/env node

// db2
var SecretStack  = require('secret-stack')
var caps         = require('ssb-caps')
var Config       = require('ssb-config/inject')
var minimist     = require('minimist')

var argv = process.argv.slice(2)
var i = argv.indexOf('--')
var conf = argv.slice(i+1)
argv = ~i ? argv.slice(0, i) : argv

var config = Config(process.env.ssb_appname, minimist(conf))
config.db2 = { automigrate : true, dangerouslyKillFlumeWhenMigrated : true }
console.log(config)

if (argv[0] == 'start') {
  var createSsbServer = SecretStack({ caps })
    .use(require('ssb-master'))
    .use(require('ssb-db2'))
    .use(require('ssb-db2/compat'))
    .use(require('ssb-lan'))
    .use(require('ssb-friends'))
    .use(require('ssb-ebt'))
    .use(require('ssb-conn'))
    .use(require('ssb-replicate'))
    .use(require('ssb-replication-scheduler'))

  // start server
  var server = createSsbServer(config)
  // gracefully exit process
  process.once("SIGINT", function (code) {
    console.log("sig int received")
    server.close(true, () => {
      console.log("exiting")
      process.exit()
    })
  })
}
