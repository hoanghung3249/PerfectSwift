//
//  Extensions.swift
//  PerfectDatabase
//
//  Created by HOANGHUNG on 2/21/18.
//

import Foundation

extension String {
    
    func convertToDictionary() -> [String: Any] {
        var dic = [String: Any]()
        if let data = self.data(using: .utf8) {
            do {
                dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
                return dic
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        return dic
    }
    
}
