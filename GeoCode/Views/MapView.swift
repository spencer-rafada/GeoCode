//
//  ContentView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/8/22.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject private var vm: CountryViewModel
    var body: some View {
        List {
            ForEach(vm.allCountries, id:\.name?.common) {country in
                Text(country.name?.common ?? "None")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(country.capital?[0] ?? "No capital listed")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Lat: \(country.latlng?[0] ?? 0), Long: \(country.latlng?[1] ?? 0)")
            }
        }
        .padding()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(CountryViewModel())
    }
}
