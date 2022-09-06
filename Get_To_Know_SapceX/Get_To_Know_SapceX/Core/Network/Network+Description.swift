//
//  Network+Description.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import Foundation

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noData:
            return "The provided password is not valid."
        case .noInteretConnection(let desc):
            return "The Desc is \(desc)."
        case .serverError(statusCode: let int):
            return "An unexpected error occurred.\(String(int))"
        case .transportError(_):
            return "An Error"
        case .decodingError(_):
            return "An Error"
        case .encodingError(_):
            return "An Error"
        }
    }
}
