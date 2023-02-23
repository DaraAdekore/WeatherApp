//
//  ZipCodeResponse.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import Foundation

// MARK: - ZipCodeResponse
struct ZipCodeResponse: Codable {
    let zip, name: String
    let lat, lon: Double
    let country: String
}
