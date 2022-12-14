//
//  ContentView.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/8/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var mv: MapViewModel
    
    var body: some View {
        if mv.isFetching {
            VStack {
                Spacer()
                Text("Fetching Data...")
                ProgressView()
                Spacer()
            }
            
        }
        ZStack {
            mapLayer
            .ignoresSafeArea()
            
            VStack (spacing: 0) {
//                SearchBarView(searchText: $mv.searchText)
                Spacer()
                countriesPreview
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }

        }
        .sheet(item: $mv.sheetCountry, onDismiss: nil) { country in
            CountryDetailView(country: country)
        }
        .task {
            await mv.fetchData()
            mv.transferData()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapViewModel())
    }
}

extension MapView {
    private var mapLayer: some View {
        Map(coordinateRegion: $mv.countryRegion, annotationItems: mv.countries, annotationContent: {country in
            MapAnnotation(coordinate: country.coordinates) {
                CountryMapAnnotationView()
                    .scaleEffect(mv.countryLoc == country ? 1 : 0.6)
                    .shadow(radius: 10)
                    .onTapGesture {
                        mv.showNextCountry(country: country)
                    }
            }
        })
    }
    
    private var countriesPreview: some View {
            ZStack {
                ForEach(mv.countries) { country in
                    if mv.countryLoc == country {
                        CountryPreviewView(country: country)
                            .shadow(color: Color.black.opacity(0.3), radius: 20)
                            .padding()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)))
                    }
                }
            }
        }
}
