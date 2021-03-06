//
//  Routes.swift
//  PerfectDatabasePackageDescription
//
//  Created by HOANGHUNG on 2/19/18.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct Router {
    
    func getRoutes() -> Routes {
        var routes = Routes()
        
        routes.add(method: .get, uri: "hello") { (req, res) in
            
            res.setBody(string: "Welcome to Perfect Database")
            .completed()
            
        }
        
        routes.add(method: .post, uri: "user") { (req, res) in
            do {
                guard let json = try req.postBodyString?.jsonDecode() else { throw HTTPResponseError(status: .badRequest, description: "") }
                let paramString = try json.jsonEncodedString()
                let paramDic = paramString.convertToDictionary()
                let userObj = User()
                userObj.createUser(with: paramDic, { (isSuccess, mess) in
                    do {
                        if isSuccess {
                            try res.setBody(json: json).completed()
                        } else {
                            res.setBody(string: mess).completed()
                        }
                    } catch {
                        res.status = .badRequest
                        res.completed()
                    }
                })
            } catch {
                res.status = .badRequest
                res.completed()
            }
        }
        
        routes.add(method: .get, uri: "getUsers") { (req, res) in
            do {
                var arrUser = [User]()
                let objUser = User()
                arrUser = objUser.rows()
                var userDic = [[String: Any]]()
                arrUser.forEach({ (user) in
                    let dic = [
                        "id": user.id,
                        "name": user.name,
                        "phone": user.phone,
                        "email": user.email
                    ] as [String: Any]
                    userDic.append(dic)
                })
                let jsonRes = ["users": userDic]
                try res.setBody(json: jsonRes).completed()
            } catch {
                res.status = .badRequest
                res.completed()
            }
        }
        
        routes.add(method: .post, uri: "upload") { (request, res) in
            // create uploads dir to store files
            let fileDir = Dir(Dir.workingDir.path + "files")
            do {
                try fileDir.create()
            } catch {
                print(error)
            }
            
            // Grab the fileUploads array and see what's there
            // If this POST was not multi-part, then this array will be empty
            if let uploads = request.postFileUploads, uploads.count > 0 {
                // Create an array of dictionaries which will show what was uploaded
                var ary = [[String:Any]]()
                
                for upload in uploads {
                    ary.append([
                        "fieldName": upload.fieldName,
                        "contentType": upload.contentType,
                        "fileName": upload.fileName,
                        "fileSize": upload.fileSize,
                        "tmpFileName": upload.tmpFileName
                        ])
                    // move file to webroot
                    let thisFile = File(upload.tmpFileName)
                    do {
                        let _ = try thisFile.moveTo(path: fileDir.path + upload.fileName, overWrite: true)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        return routes
    }
    
}
