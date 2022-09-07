//
//  Service.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import Foundation

class Service {
    
    public static func tempRequest(request: Mission.Request,
                                   completion:
                                   @escaping (Result<Mission.Response, NetworkError>) -> Void) {
        
        if let data = makeContentBody(encode: request), let url = request.getRequestURL() {
            makePostRequest(postData: data, url: url, header: request.header) { data, response, error in
                if let networkError = NetworkError(data: data, response: response, error: error) {
                    completion(.failure(networkError))
                    return
                }
                if let networkError = NetworkError(data: data, response: response, error: error) {
                    completion(.failure(networkError))
                }
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(Mission.Response.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError(error)))
                }
            }
        } else {
            print("Error")
        }
        
    }
    
}
