//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//    Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import MySQLStORM
import StORM

let server = HTTPServer()

server.serverPort = 8080

let routes = Router().getRoutes()
server.addRoutes(routes)

//MySQLFile().connectDatabase()
MySQLConnector.host = "127.0.0.1"
MySQLConnector.username = "root"
MySQLConnector.password = ""
MySQLConnector.database = "perfectDBS"
MySQLConnector.port = 3306

let obj = User()
try? obj.setup()

do {
    try server.start()
} catch {
    fatalError("\(error)")
}


