//
//  Flights.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import Foundation
import MapKit

struct Flights: Identifiable, Equatable {
    let aircraft: String
    let arrival: String
    let departure: String
    let flightNumber: String
    let coordinates: CLLocationCoordinate2D
    let flightStatus: String
    let altitude: Double
    
    // Identifiable
    var id: String {
        "\(aircraft)_\(flightNumber)"
    }
    
    // Equatable
    static func == (lhs: Flights, rhs: Flights) -> Bool {
        lhs.id == rhs.id
    }
}
