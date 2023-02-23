//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import Foundation
import Alamofire
class NetworkManager {
    static let shared = NetworkManager()
    let apiKey = "33e1f41bba4a75c81313adfc371840c5"
    enum APIResponse<T> {
        case success(T)
        case failure(Error)
    }
    private init(){}
    func request(with userInput:String,and type:String, completion : @escaping (APIResponse<Any>) -> Void){
        if type == "cityNameObject" {
            AF.request(userInput).responseDecodable(of: CityNameResponses.self){ response in
                switch response.result {
                case .success(let data):
                    if data.count == 0 {
                        print("Nothing found")
                    }
                    else{
                        completion(.success(data))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        else if type == "zipObject" {
            AF.request(userInput).responseDecodable(of: ZipCodeResponse.self){ response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        else{
            AF.request(userInput).responseDecodable(of: WeatherDataResponse.self){ response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func request(with weatherIcon:String, completion: @escaping (Result<Data,Error>) -> Void){
        AF.request("https://openweathermap.org/img/wn/\(weatherIcon)@2x.png").responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    func getInputType(with userInput:String) -> String{
        if userInput.contains("geo"){
            if userInput.contains("zip"){
                return "zipObject"
            }
            else{
                return "cityNameObject"
            }
        }
        else{
            return "currentWeatherObject"
        }
    }
    func getGeoEndpoint(with input:String) -> String {
        
        if let zipCode = Int(input), input.count == 5 {
            // User input is a valid 5-digit number, assume it is a zip code
            return "https://api.openweathermap.org/geo/1.0/zip?zip=\(zipCode),US&limit=1&appid=\(apiKey)"
        } else {
            // User input is not a valid 5-digit number, assume it is a city name
            return  "https://api.openweathermap.org/geo/1.0/direct?q=\(input.replacingOccurrences(of: " ", with: "%20"))&limit=1&appid=\(apiKey)"
        }
        return "NOTHING!"
    }
    func getWeatherEndpoint(with input:(String,String)) -> String{
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(input.0)&lon=\(input.1)&appid=\(apiKey)"
    }
}
