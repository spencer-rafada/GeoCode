//
//  CountryDataService.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/9/22.
//

import Foundation
import Combine

class CountriesDataService {
    @Published var allCountries: [CountryModel] = []
    var countrySubscription: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getCountries()
    }
    
    func getCountries() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {return}
        
        // Combine analogy
        /*
        // 1. Sign up for monthly subscription for package to be delivered
        // 2. The Company would make the package behind the scenes
        // 3. Receive the package at your front door
        // 4. Check the box isn't damaged
        // 5. Open and make sure the item is correct
        // 6. use the item
        // 7. cancellable at any time
        */
         
        // 1. create the publisher
        countrySubscription = URLSession.shared.dataTaskPublisher(for: url)
        // 2. subscribe the publisher on background thread <- increases performance
            .subscribe(on: DispatchQueue.global(qos: .default))
        // 3. receive on main thread
            .receive(on: DispatchQueue.main)
        // 4. tryMap (check that the data is good)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
        // 5. decode data into CountriesJSON model
            .decode(type: [CountryModel].self, decoder: JSONDecoder())
        // 6. sink (put them into our app)
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedCountries) in
                self?.allCountries = returnedCountries
                print("Countries: \(returnedCountries)")
            }
        // 7. store (cancel subscription if needed)
//            .store(in: &cancellables)
        

    }
}


