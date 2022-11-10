//
//  CountryPreviewView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import SwiftUI
import MapKit

struct CountryPreviewView: View {
    @EnvironmentObject private var mv: MapViewModel
    let country: Country
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                title
            }
            
            VStack (spacing: 8) {
                details
                HStack {
                    nextButton
                    prevButton
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .offset(y: 70))
        .cornerRadius(10)
    }
}

struct CountryPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPreviewView(country: Country(name: "Mauritania", officialName: "Islamic Republic of Mauritania", coordinates: CLLocationCoordinate2D(latitude: 20, longitude: -12), independent: true, unMember: true, region: "Africa", population: 4649660, capital: "Nouakchott", flags: "https://flagcdn.com/w320/aw.png", capitalInfo: CLLocationCoordinate2D(latitude: 14.6, longitude: 120.97)))
            .environmentObject(MapViewModel())
    }
}

extension CountryPreviewView{
    private var imageSection: some View {
        ZStack {
            if let flags = country.flags {
                let url = URL(string: flags)
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .padding()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .padding(7)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var title: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(country.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(country.capital)
                .font(.title3)
            
            Text(country.officialName)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var details: some View {
        Button {
            mv.sheetCountry = country
        } label: {
            Text("Details")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            mv.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 65, height: 30)
        }
        .buttonStyle(.bordered)
    }
    
    private var prevButton: some View {
        Button {
            mv.prevButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 65, height: 30)
        }
        .buttonStyle(.bordered)
    }
}
