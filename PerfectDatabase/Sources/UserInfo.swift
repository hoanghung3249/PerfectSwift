//
//  UserInfo.swift
//  PerfectDatabase
//
//  Created by HOANGHUNG on 2/19/18.
//

import PerfectMySQL
import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import MySQLStORM
import StORM


public class UserInfo: JSONConvertibleObject {
    
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    
    public override func setJSONValues(_ values: [String : Any]) {
        self.name = values["name"] as? String ?? ""
        self.phone = values["phone"] as? String ?? ""
        self.email = values["email"] as? String ?? ""
    }
    
    public override func getJSONValues() -> [String : Any] {
        return [
            "name": name,
            "phone": phone,
            "email": email
        ]
    }
    
}

public class User: MySQLStORM {
    
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var avatar: String = ""
    
    // The name of the database table
    public override func table() -> String {
        return "UserProfile"
    }
    
    // The mapping that translates the database info back to the object
    // This is where you would do any validation or transformation as needed
    public override func to(_ this: StORMRow) {
        id              = this.data["id"] as? Int ?? 0
        name            = this.data["name"] as? String ?? ""
        phone           = this.data["phone"] as? String ?? ""
        email           = this.data["email"] as? String ?? ""
        avatar          = this.data["avatar"] as? String ?? ""
    }
    
    // Create user profile and insert to dbs
    func createUser(with value: [String: Any],_ completion: ((_ isSuccess: Bool, _ mess: String)->())) {
        print(value["phone"] as? String ?? "nothing")
        name = value["name"] as? String ?? ""
        phone = value["phone"] as? String ?? ""
        email = value["email"] as? String ?? ""
        
        do {
            try self.create()
            completion(true, "")
        } catch {
            completion(false, error.localizedDescription)
        }
    }
    
    // A simple iteration.
    // Unfortunately necessary due to Swift's introspection limitations
    func rows() -> [User] {
        do {
            try self.findAll()
        } catch {
            
        }
        var rows = [User]()
        for i in 0..<self.results.rows.count {
            let row = User()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
    
}

