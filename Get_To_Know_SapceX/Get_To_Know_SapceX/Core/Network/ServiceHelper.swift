//
//  ServiceHelper.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import Foundation
extension Service {
    static func makeContentBody<T: Codable>(encode: T)  -> Data? {
        do {
            let data = try JSONEncoder().encode(encode)
            return data
        } catch {
            print("\(#function) ___ 🚩 BEGIN 🚩 ___\n")
            print("❌ Error in encoding data\n")
            print( error.localizedDescription)
            print("\(#function) ___ 🏁 END 🏁 ___")
            return nil
        }
        
    }
    
    static func makePostRequest(postData: Data?,
                                url: URL,
                                header: [HTTPHeader],
                                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let headers = [ "Content-Type": "application/json", "Accept":"application/json"]
        var request = URLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HttpMethod.post.rawValue
//        request.setHTTPHeader(headers: header)

        if postData != nil {
            request.httpBody = postData
            request.allHTTPHeaderFields = headers
        }
    
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest){ (data, response, error) -> Void in
//            let json = try? JSONSerialization.jsonObject(with: data!)
//            print("\(json)")
            completionHandler(data, response, error)
        }
        
        dataTask.resume()
    }
    
    static func makeGetRequest(postData: Data?, url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        
    }
}

extension URLRequest {
    mutating func setHTTPHeader(headers: [HTTPHeader]) {
        for header in headers {
            self.setValue(header.value, forHTTPHeaderField: header.name)
        }
    }
}

