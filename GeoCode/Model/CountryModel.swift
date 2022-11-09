//
//  CountryModel.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/9/22.
//

//{
//    "name": {
//        "common": "Barbados",
//        "official": "Barbados",
//        "nativeName": {
//            "eng": {
//                "official": "Barbados",
//                "common": "Barbados"
//            }
//        }
//    },
//    "tld": [
//        ".bb"
//    ],
//    "cca2": "BB",
//    "ccn3": "052",
//    "cca3": "BRB",
//    "cioc": "BAR",
//    "independent": true,
//    "status": "officially-assigned",
//    "unMember": true,
//    "currencies": {
//        "BBD": {
//            "name": "Barbadian dollar",
//            "symbol": "$"
//        }
//    },
//    "idd": {
//        "root": "+1",
//        "suffixes": [
//            "246"
//        ]
//    },
//    "capital": [
//        "Bridgetown"
//    ],
//    "altSpellings": [
//        "BB"
//    ],
//    "region": "Americas",
//    "subregion": "Caribbean",
//    "languages": {
//        "eng": "English"
//    },
//    "translations": {
//        "ara": {
//            "official": "باربادوس",
//            "common": "باربادوس"
//        },
//        "bre": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "ces": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "cym": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "deu": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "est": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "fin": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "fra": {
//            "official": "Barbade",
//            "common": "Barbade"
//        },
//        "hrv": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "hun": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "ita": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "jpn": {
//            "official": "バルバドス",
//            "common": "バルバドス"
//        },
//        "kor": {
//            "official": "바베이도스",
//            "common": "바베이도스"
//        },
//        "nld": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "per": {
//            "official": "باربادوس",
//            "common": "باربادوس"
//        },
//        "pol": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "por": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "rus": {
//            "official": "Барбадос",
//            "common": "Барбадос"
//        },
//        "slk": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "spa": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "swe": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "tur": {
//            "official": "Barbados",
//            "common": "Barbados"
//        },
//        "urd": {
//            "official": "بارباڈوس",
//            "common": "بارباڈوس"
//        },
//        "zho": {
//            "official": "巴巴多斯",
//            "common": "巴巴多斯"
//        }
//    },
//    "latlng": [
//        13.16666666,
//        -59.53333333
//    ],
//    "landlocked": false,
//    "area": 430,
//    "demonyms": {
//        "eng": {
//            "f": "Barbadian",
//            "m": "Barbadian"
//        },
//        "fra": {
//            "f": "Barbadienne",
//            "m": "Barbadien"
//        }
//    },
//    "flag": "🇧🇧",
//    "maps": {
//        "googleMaps": "https://goo.gl/maps/2m36v8STvbGAWd9c7",
//        "openStreetMaps": "https://www.openstreetmap.org/relation/547511"
//    },
//    "population": 287371,
//    "fifa": "BRB",
//    "car": {
//        "signs": [
//            "BDS"
//        ],
//        "side": "left"
//    },
//    "timezones": [
//        "UTC-04:00"
//    ],
//    "continents": [
//        "North America"
//    ],
//    "flags": {
//        "png": "https://flagcdn.com/w320/bb.png",
//        "svg": "https://flagcdn.com/bb.svg"
//    },
//    "coatOfArms": {
//        "png": "https://mainfacts.com/media/images/coats_of_arms/bb.png",
//        "svg": "https://mainfacts.com/media/images/coats_of_arms/bb.svg"
//    },
//    "startOfWeek": "monday",
//    "capitalInfo": {
//        "latlng": [
//            13.1,
//            -59.62
//        ]
//    },
//    "postalCode": {
//        "format": "BB#####",
//        "regex": "^(?:BB)*(\\d{5})$"
//    }
//},

import Foundation

// MARK: - CountryModel
struct CountryModel: Equatable, Codable {
    let name: Name?
    let tld: [String]?
    let cca2, ccn3, cca3, cioc: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    let currencies: Currencies?
    let idd: Idd?
    let capital, altSpellings: [String]?
    let region, subregion: String?
    let languages: Languages?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let landlocked: Bool?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let fifa: String?
    let car: Car?
    let timezones, continents: [String]?
    let flags, coatOfArms: CoatOfArms?
    let startOfWeek: String?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
    
    
    enum CodingKeys: String, CodingKey {
        case name, tld, cca2, ccn3, cca3, cioc
        case independent, status, unMember, currencies
        case idd, capital, altSpellings, region, subregion
        case languages, translations, latlng, landlocked
        case area, demonyms, flag, maps, population, fifa
        case car, timezones, continents, flags, coatOfArms
        case startOfWeek, capitalInfo, postalCode
    }
    
    // update countries
    func updateCountries() -> CountryModel {
        return CountryModel(name: name, tld: tld, cca2: cca2, ccn3: ccn3, cca3: cca3, cioc: cioc, independent: independent, status: status, unMember: unMember, currencies: currencies, idd: idd, capital: capital, altSpellings: altSpellings, region: region, subregion: subregion, languages: languages, translations: translations, latlng: latlng, landlocked: landlocked, area: area, demonyms: demonyms, flag: flag, maps: maps, population: population, fifa: fifa, car: car, timezones: timezones, continents: continents, flags: flags, coatOfArms: coatOfArms, startOfWeek: startOfWeek, capitalInfo: capitalInfo, postalCode: postalCode)
    }
}

// MARK: - CapitalInfo
struct CapitalInfo: Equatable, Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Equatable, Codable {
    let signs: [String]?
    let side: String?
}

// MARK: - CoatOfArms
struct CoatOfArms: Equatable, Codable {
    let png: String?
    let svg: String?
}

// MARK: - Currencies
struct Currencies: Equatable, Codable {
    let bbd: Bbd?
}

// MARK: - Bbd
struct Bbd: Equatable, Codable {
    let name, symbol: String?
}

// MARK: - Demonyms
struct Demonyms: Equatable, Codable {
    let eng, fra: Eng?
}

// MARK: - Eng
struct Eng: Equatable, Codable {
    let f, m: String?
}

// MARK: - Idd
struct Idd: Equatable, Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Languages
struct Languages: Equatable, Codable {
    let eng: String?
}

// MARK: - Maps
struct Maps: Equatable, Codable {
    let googleMaps, openStreetMaps: String?
}

// MARK: - Name
struct Name: Equatable, Codable {
    let common, official: String?
    let nativeName: NativeName?
}

// MARK: - NativeName
struct NativeName: Equatable, Codable {
    let eng: Translation?
}

// MARK: - Translation
struct Translation: Equatable, Codable {
    let official, common: String?
}

// MARK: - PostalCode
struct PostalCode: Equatable, Codable {
    let format, regex: String?
}
