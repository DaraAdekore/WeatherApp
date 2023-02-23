//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import Foundation


// MARK: - WeatherResponseElement
struct CityNameResponse: Codable {
    let name: String?
    let localNames: LocalNames?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let be, kn, fa, th: String?
    let mi, uk, tt, el: String?
    let en, ka, ba, de: String?
    let pt, ko, bn, he: String?
    let gl, zh, oc, ar: String?
    let ta, ja, sr, it: String?
    let pl, ru, eo, es: String?
    let lv, hi, fr: String?
}

typealias CityNameResponses = [CityNameResponse]
