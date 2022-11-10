//
//  MapViewModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import Foundation
import MapKit

struct Country: Identifiable, Equatable {
    let name: String
    let officialName: String
    let coordinates: CLLocationCoordinate2D
    let independent: Bool
    let unMember: Bool
    let region: String
    let population: Int
    // Include capital info next time
    // flags
    
    // Identifiable
    var id: String {
        "\(region)_\(name)_\(officialName)"
    }
    
    // Equatable
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
}
