//
//  CountryViewModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/9/22.
//

import Foundation
import Combine
import MapKit
import SwiftUI

class CountryViewModel: ObservableObject {
    // Initialize the array with an empty object to get around the init()
    @Published var countries: [Country] = []
    
    private let dataService = CountriesDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addCountries()
    }
    
    func addCountries() {
        dataService.$allCountries
            .map { (countryModel: [CountryModel]) -> [Country] in
                var countries: [Country] = []
                
                guard countryModel != nil else {
                    return countries
                }
                
                for country in countryModel {
                    let name = country.name?.common ?? "None"
                    let officialName = country.name?.official ?? "No official name"
                    let coordinates = CLLocationCoordinate2D(latitude: country.latlng?[0] ?? 0, longitude: country.latlng?[1] ?? 0)
                    let independent = country.independent ?? false
                    let unMember = country.unMember ?? false
                    let region = country.region ?? "Somewhere"
                    let population = country.population ?? 0
                    let capital = country.capital?[0] ?? "No capital"
                    let flags = country.flags?.png ?? "No flags"
                    let capitalInfo = CLLocationCoordinate2D(latitude: country.capitalInfo?.latlng?[0] ?? 0, longitude: country.capitalInfo?.latlng?[1] ?? 0)
                    countries.append(Country(name: name, officialName: officialName, coordinates: coordinates, independent: independent, unMember: unMember, region: region, population: population, capital: capital, flags: flags, capitalInfo: capitalInfo))
                }
                
                return countries
            }
            .sink(receiveValue: { [weak self] (returnedCountries) in
                self?.countries = returnedCountries
            })
            .store(in: &cancellables)
    }
}
