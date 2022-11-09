//
//  CountryViewModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/9/22.
//

import Foundation
import Combine

class CountryViewModel: ObservableObject {
    @Published var allCountries: [CountryModel] = []
    
    private let dataService = CountriesDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addCountries()
    }
    
    func addCountries() {
        dataService.$allCountries
            .sink { [weak self] (returnedCountries) in
                self?.allCountries = returnedCountries
            }
            .store(in: &cancellables)
    }
}
