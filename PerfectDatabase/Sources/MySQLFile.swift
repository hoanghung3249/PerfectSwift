//
//  MySQLFile.swift
//  PerfectDatabase
//
//  Created by HOANGHUNG on 2/19/18.
//

import PerfectLib
import PerfectHTTPServer
import PerfectHTTP
import PerfectMySQL

struct MySQLFile {
    
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = ""
    let testDB = "perfectDBS"
    
    func connectDatabase() {
        
        let mySQL = MySQL()
        let connected = mySQL.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
        guard connected else {
            // verify we connected successfully
            print(mySQL.errorMessage())
            return
        }
        
        defer {
            mySQL.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
        
    }
    
}
