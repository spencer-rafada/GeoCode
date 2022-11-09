//
//  GeoCodeApp.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/8/22.
//

import SwiftUI

@main
struct GeoCodeApp: App {
    @State private var vm = CountryViewModel()
    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(vm)
        }
    }
}
