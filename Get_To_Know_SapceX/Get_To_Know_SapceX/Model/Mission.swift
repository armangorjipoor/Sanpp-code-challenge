//
//  Model.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/15/1401 AP.
//

import Foundation
struct Mission {

    struct Request: Codable {
        
        func getRequestURL() -> URL? {
            let urlComponent = URLComponents(string: "https://api.spacexdata.com/v5/launches/query" )
            return urlComponent?.url
        }
        
        var header:[HTTPHeader] {
            get {
                return [HTTPHeader(name: "Content-Type", value: "application/json"),
                        HTTPHeader(name: "Accept", value: "application/json")]
                
            }
        }
        
        let query: Query
        let options: Options
    }

    // MARK: - Options
    struct Options: Codable {
        let limit, page: Int
        let sort: Sort
    }

    // MARK: - Sort
    struct Sort: Codable {
        let flightNumber: String

        enum CodingKeys: String, CodingKey {
            case flightNumber = "flight_number"
        }
    }

    // MARK: - Query
    struct Query: Codable {
        let upcoming: Bool
    }

    struct Response: Codable {
        let docs: [Doc]
        let totalDocs, limit, totalPages, page: Int?
        let pagingCounter: Int
        let hasPrevPage, hasNextPage: Bool?
        let prevPage, nextPage: Int?
    }

    // MARK: - Doc
    struct Doc: Codable {
        let fairings: Fairings?
        let links: Links
        let staticFireDateUTC: String?
//        let staticFireDateUnix: Int?
        let net: Bool
        let window: Int?
        let rocket: Rocket
        let success: Bool
        let details: String?
        let crew: [Crew]
        let ships, capsules, payloads: [String]
//        let launchpad: Launchpad
//        let flightNumber: Int
        let name, dateUTC: String
        let dateUnix: Int
        let dateLocal: String
//        let datePrecision: DatePrecision
//        let upcoming: Bool
        let cores: [Core]
//        let autoUpdate, tbd: Bool
//        let launchLibraryID: String?
        let id: String

        enum CodingKeys: String, CodingKey {
            case links
            case fairings
            case staticFireDateUTC = "static_fire_date_utc"
//            case staticFireDateUnix = "static_fire_date_unix"
            case net,ships, capsules, payloads
            case success
            case window
//            case launchpad
            case rocket
            case crew
//            case flightNumber = "flight_number"
            case name
            case dateUTC = "date_utc"
            case dateUnix = "date_unix"
            case dateLocal = "date_local"
//            case datePrecision = "date_precision"
//            case upcoming
            case details
            case cores
//            case autoUpdate = "auto_update"
//            case tbd
//            case launchLibraryID = "launch_library_id"
            case id
        }
    }

    // MARK: - Core
    struct Core: Codable {
        let core: String
        let flight: Int
        let gridfins, legs, reused, landingAttempt: Bool
        let landingSuccess: Bool
        let landingType: LandingType
//        let landpad: Landpad

        enum CodingKeys: String, CodingKey {
            case core, flight, gridfins, legs, reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
//            case landpad
        }
    }

    enum LandingType: String, Codable {
        case asds = "ASDS"
        case rtls = "RTLS"
    }

    enum Landpad: String, Codable {
        case the5E9E3032383Ecb267A34E7C7 = "5e9e3032383ecb267a34e7c7"
        case the5E9E3032383Ecb6Bb234E7CA = "5e9e3032383ecb6bb234e7ca"
        case the5E9E3033383Ecb075134E7CD = "5e9e3033383ecb075134e7cd"
        case the5E9E3033383Ecbb9E534E7Cc = "5e9e3033383ecbb9e534e7cc"
    }

    // MARK: - Crew
    struct Crew: Codable {
        let crew, role: String
    }

    enum DatePrecision: String, Codable {
        case hour = "hour"
    }

    // MARK: - Fairings
    struct Fairings: Codable {
        let reused, recoveryAttempt, recovered: Bool?
        let ships: [String]

        enum CodingKeys: String, CodingKey {
            case reused
            case recoveryAttempt = "recovery_attempt"
            case recovered, ships
        }
    }

    enum Launchpad: String, Codable {
        case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
        case the5E9E4502F509092B78566F87 = "5e9e4502f509092b78566f87"
        case the5E9E4502F509094188566F88 = "5e9e4502f509094188566f88"
    }

    // MARK: - Links
    struct Links: Codable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr
        let presskit: JSONNull?
        let webcast: String
        let youtubeID: String
        let article, wikipedia: String?

        enum CodingKeys: String, CodingKey {
            case patch, reddit, flickr, presskit, webcast
            case youtubeID = "youtube_id"
            case article, wikipedia
        }
    }

    // MARK: - Flickr
    struct Flickr: Codable {
        let small: [JSONAny]
        let original: [String]
    }

    // MARK: - Patch
    struct Patch: Codable {
        let small, large: String
    }

    // MARK: - Reddit
    struct Reddit: Codable {
        let campaign: String
        let launch: String?
        let media: JSONNull?
        let recovery: String?
    }

    enum Rocket: String, Codable {
        case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    }

}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
/*enum CodingKeys: String, CodingKey {
//            case links
//            case fairings
//            case staticFireDateUTC = "static_fire_date_utc"
//            case staticFireDateUnix = "static_fire_date_unix"
    case net, window , success, details, ships, capsules, payloads
//            case launchpad
//            case rocket
//            case crew
    case flightNumber = "flight_number"
    case name
    case dateUTC = "date_utc"
    case dateUnix = "date_unix"
    case dateLocal = "date_local"
//            case datePrecision = "date_precision"
    case upcoming
//            case cores
    case autoUpdate = "auto_update"
    case tbd
    case launchLibraryID = "launch_library_id"
    case id
}
*/
