//
//  MapViewModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var isFetching = false
    @Published var allCountries: [CountryModel] = []
    @Published var errorMessage = ""
    @Published var countries: [Country] = []
    
    // Current location on the map
    @Published var countryLoc: Country {
        didSet {
            updateCountryRegion(country: countryLoc)
        }
    }
    
    // Current region on the map
    @Published var countryRegion: MKCoordinateRegion = MKCoordinateRegion()
    let countrySpan = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
    
    // Show the details via sheet
    @Published var sheetCountry: Country? = nil
    
    init () {
        let placeholder = Country(name: "Philippines", officialName: "Republic of the Philippines", coordinates: CLLocationCoordinate2D(latitude: 13, longitude: 122), independent: true, unMember: true, region: "Asia", population: 109581085, capital: "Manila", flags: "https://flagcdn.com/w320/ph.png", capitalInfo: CLLocationCoordinate2D(latitude: 14.6, longitude: 120.97))
        self.countryLoc = placeholder
        self.updateCountryRegion(country: placeholder)
    }
    
    @MainActor
    func fetchData() async {
        let urlString = "https://restcountries.com/v3.1/all"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            isFetching = true
            let(data, response) = try await URLSession.shared.data(from: url)
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                self.errorMessage = "Failed to hit endpoint with bad status code"
            }
            
            self.allCountries = try await JSONDecoder().decode([CountryModel].self, from: data)
            isFetching = false
//            print(allCountries)
        } catch {
            isFetching = false
            print("Failed to reach endpoint: \(error)")
        }
    }
    
    // Transfer from CountryModel to Country
    func transferData() {
        for country in allCountries {
            let name = country.name?.common ?? "None"
            let officialName = country.name?.official ?? "No official name"
            let coordinates = CLLocationCoordinate2D(latitude: country.latlng?[0] ?? 0, longitude: country.latlng?[1] ?? 0)
            let independent = country.independent ?? false
            let unMember = country.unMember ?? false
            let region = country.region ?? "Somewhere"
            let population = country.population ?? 0
            let capital = country.capital?[0] ?? "No capital"
            let flags = country.flags?.png ?? "No flag"
            let capitalInfo = CLLocationCoordinate2D(latitude: country.capitalInfo?.latlng?[0] ?? 0, longitude: country.capitalInfo?.latlng?[1] ?? 0)
            self.countries.append(Country(name: name, officialName: officialName, coordinates: coordinates, independent: independent, unMember: unMember, region: region, population: population, capital: capital, flags: flags, capitalInfo: capitalInfo))
            print(countries)
        }
    }
    
    
    private func updateCountryRegion(country: Country) {
        withAnimation(.easeInOut) {
            countryRegion = MKCoordinateRegion(center: country.coordinates, span: countrySpan)
        }
    }
    
    func showNextCountry(country: Country) {
        withAnimation(.easeInOut) {
            countryLoc = country
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = countries.firstIndex(where: {$0 == countryLoc}) else {
            print("Could not find current index! This should never happen")
            return
        }
        
        // Check if current index is valid
        let nextIndex = currentIndex + 1
        guard countries.indices.contains(nextIndex) else {
            guard let firstIndex = countries.first else { return }
            showNextCountry(country: firstIndex)
            return
        }
        
        // If next index is valid
        let nextCountry = countries[nextIndex]
        showNextCountry(country: nextCountry)
    }
    
    func prevButtonPressed() {
        guard let currentIndex = countries.firstIndex(where: {$0 == countryLoc}) else {
            print("Could not find current index! This should never happen")
            return
        }
        
        // Check if current index is valid
        let nextIndex = currentIndex - 1
        guard countries.indices.contains(nextIndex) else {
            guard let firstIndex = countries.last else { return }
            showNextCountry(country: firstIndex)
            return
        }
        
        // If next index is valid
        let nextCountry = countries[nextIndex]
        showNextCountry(country: nextCountry)
    }
    
    func goToCapital() {
        sheetCountry = nil
        countryRegion = MKCoordinateRegion(center: countryLoc.capitalInfo, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
    }
}
