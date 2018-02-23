//
//  JSONResponse.swift
//  PerfectDatabase
//
//  Created by HUNGNGUYEN on 2/23/18.
//

import PerfectLib
import Foundation

public class JSONResponse: JSONConvertibleObject {
    
    var status_code: Int = 0
    var message: String = ""
    var status: String = ""
    var data: Any? = nil
    
    
    public override func setJSONValues(_ values: [String : Any]) {
        self.status_code = values["status_code"] as? Int ?? 0
        self.message = values["message"] as? String ?? ""
        self.status = values["status"] as? String ?? ""
        self.data = values["data"]
    }
    
    public override func getJSONValues() -> [String : Any] {
        return [
            "status_code": status_code,
            "message": message,
            "status": status,
            "data": data ?? []
        ]
    }
    
}
