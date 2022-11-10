//
//  FlightsModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import Foundation

// MARK: - FlightsModel
struct FlightsModel: Codable, Equatable {
    let success: Bool?
    let total: Int?
    let data: [Datum]?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
struct Datum: Codable, Equatable {
    let aircraft: Aircraft?
    let airline, arrival, departure: Airline?
    let flight: Flight?
    let geography: Geography?
    let speed: Speed?
    let status: Status?
    let system: System?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Aircraft
struct Aircraft: Codable, Equatable {
    let iataCode, icao24, icaoCode, regNumber: String?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Airline
struct Airline: Codable, Equatable {
    let iataCode, icaoCode: String?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Flight
struct Flight: Codable, Equatable {
    let iataNumber, icaoNumber, number: String?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Geography
struct Geography: Codable, Equatable {
    let altitude: Double?
    let direction: Int?
    let latitude, longitude: Double?
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Speed
struct Speed: Codable, Equatable {
    let horizontal: Double?
    let isGround, vspeed: Int?
}

enum Status: String, Codable, Equatable {
    case enRoute = "en-route"
    case landed = "landed"
    case started = "started"
    case unknown = "unknown"
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - System
struct System: Codable, Equatable {
    let squawk: JSONNull?
    let updated: Int?
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
