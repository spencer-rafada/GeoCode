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
    
    @Published var allFlights: [Datum] = []
    @Published var flights: [Flights] = []
    
    @Published var isCountry: Bool = false
    
    // Current location on the map
    @Published var countryLoc: Country {
        didSet {
            updateCountryRegion(country: countryLoc)
        }
    }
    
    // Current flight on the map
    @Published var flightLoc: Flights {
        didSet {
            updateFlightRegion(flight: flightLoc)
        }
    }
    
    // Current region on the map
    @Published var countryRegion: MKCoordinateRegion = MKCoordinateRegion()
    let countrySpan = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
    
    // Current flight on the map
    @Published var flightRegion: MKCoordinateRegion = MKCoordinateRegion()
    let flightSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show the details via sheet
    @Published var sheetCountry: Country? = nil
    
    init () {
        let placeholder = Country(name: "Philippines", officialName: "Republic of the Philippines", coordinates: CLLocationCoordinate2D(latitude: 13, longitude: 122), independent: true, unMember: true, region: "Asia", population: 109581085, capital: "Manila", flags: "https://flagcdn.com/w320/ph.png", capitalInfo: CLLocationCoordinate2D(latitude: 14.6, longitude: 120.97))
        self.countryLoc = placeholder
        
        let flightsPlaceholder = Flights(aircraft: "B77W", arrival: "TPE", departure: "FRA", flightNumber: "CI62", coordinates: CLLocationCoordinate2D(latitude: 24.38, longitude: 88.89), flightStatus: "en-route", altitude: 11277.6)
        self.flightLoc = flightsPlaceholder
        self.updateFlightRegion(flight: flightsPlaceholder)
    }
    
    @MainActor
    func fetchCountryData() async {
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
            print("Failed to reach endoint: \(error)")
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
//            print(countries)
        }
    }
    
    
    private func updateCountryRegion(country: Country) {
        withAnimation(.easeInOut) {
            countryRegion = MKCoordinateRegion(center: country.coordinates, span: countrySpan)
        }
    }
    
    private func updateFlightRegion(flight: Flights) {
        withAnimation(.easeInOut) {
            flightRegion = MKCoordinateRegion(center: flight.coordinates, span: flightSpan)
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
    
    @MainActor
    func fetchFlightsData() async {
        let urlString = "https://app.goflightlabs.com/advanced-real-time-flights?access_key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiNjQ2NGVjYjc3N2UwYTBiNmI3YTE2ODE1YmY1MDg0Y2Y2YTdiNDc5ZGRmNGIxMDUxZDU3ODRjMmJlODc4ZWVhODhiNDE5OGU4MDc5MjBhZDQiLCJpYXQiOjE2NjgxMDMzMjIsIm5iZiI6MTY2ODEwMzMyMiwiZXhwIjoxNjk5NjM5MzIyLCJzdWIiOiIxNzY3NCIsInNjb3BlcyI6W119.o6za8shr3uV0vMSYEDb6WopbO88vMgCIruJCt3V1201foEJjOs3UcJBeC828YzRz91xTUwex70g1oCiR6KkUeg&limit=100"
        guard let url = URL(string: urlString) else { return }
        
        do {
            isFetching = true
            let(data, response) = try await URLSession.shared.data(from: url)
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                self.errorMessage = "Failed to hit endpoint with bad status code"
            }
            
            self.allFlights = try await JSONDecoder().decode([Datum].self, from: data)
            isFetching = false
//            print(allCountries)
        } catch {
            isFetching = false
            print("Failed to reach endpoint: \(error)")
        }
    }
    
    func transferFlightsData() {
        for flight in allFlights {
            let aircraft = flight.aircraft?.iataCode ?? "No aircraft"
            let arrival = flight.arrival?.iataCode ?? "STC"
            let departure = flight.departure?.iataCode ?? "STC"
            let flightNumber = flight.flight?.iataNumber ?? "STC-123"
            let coordinates = CLLocationCoordinate2D(latitude: flight.geography?.latitude ?? 0, longitude: flight.geography?.longitude ?? 0)
            let altitude = flight.geography?.altitude ?? 123
            let flightStatus = flight.status?.rawValue ?? "None"
            
            self.flights.append(Flights(aircraft: aircraft, arrival: arrival, departure: departure, flightNumber: flightNumber, coordinates: coordinates, flightStatus: flightStatus, altitude: altitude))
        }
    }
    
    func toggleLayer() {
        self.isCountry.toggle()
    }
}
