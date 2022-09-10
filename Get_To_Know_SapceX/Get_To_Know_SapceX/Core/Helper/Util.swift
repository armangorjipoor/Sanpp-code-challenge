//
//  Util.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import Foundation

struct Util {
    public static func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    public static func convertToPrettyJSON(with data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data)
            print("\n\n JSON is: \(json)\n\n")
        } catch {
            print("--\(#function)-- Error: \(error.localizedDescription)")
        }
    }
    
    static func logDocumentDirectory() {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {return}
        print("📂 Document Directory: \(path)")
    }
}
