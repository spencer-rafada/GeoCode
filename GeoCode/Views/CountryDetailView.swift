//
//  CountryDetailView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    @EnvironmentObject private var mv: MapViewModel
    let country: Country
    
    var body: some View {
        ScrollView{
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 0)
                VStack (alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    HStack {
                        descriptionSection
                        goToCapital
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topTrailing)
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: Country(name: "Philippines", officialName: "Republic of the Philippines", coordinates: CLLocationCoordinate2D(latitude: 13, longitude: 122), independent: true, unMember: true, region: "Asia", population: 109581085, capital: "Manila", flags: "https://flagcdn.com/w320/ph.png", capitalInfo: CLLocationCoordinate2D(latitude: 14.6, longitude: 120.97)))
    }
}

extension CountryDetailView {
    private var imageSection: some View {
        TabView {
            Image("thai")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text(country.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(country.officialName)
                .font(.title2)
                .italic()
                .foregroundColor(.gray)
            Text(country.capital)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    private var descriptionSection: some View {
        VStack (alignment: .leading, spacing: 8) {
//            let name: String
//            let officialName: String
//            let coordinates: CLLocationCoordinate2D
//            let independent: Bool
//            let unMember: Bool
//            let region: String
//            let population: Int
//            let capital: String
//            let flags: String
            Text("Region: \(country.region)")
            Text("Independent: \(country.independent ? "Yes" : "No")")
            Text("UN Member: \(country.unMember ? "Yes" : "No")")
            Text("Population: \(country.population)")
        }
        .padding()
    }
    
    private var backButton: some View {
        Button {
            mv.sheetCountry = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
    private var goToCapital: some View {
        Button {
            mv.goToCapital()
        } label: {
            Text("Go to capital.")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
}
