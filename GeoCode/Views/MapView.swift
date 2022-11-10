//
//  ContentView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/8/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var vm: CountryViewModel
    var body: some View {
        List {
            ForEach(vm.countries) { country in
                Text(country.name)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(CountryViewModel())
    }
}
