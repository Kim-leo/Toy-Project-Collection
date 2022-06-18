//
//  WeatherService.swift
//  what to wear today
//
//  Created by 김승현 on 2022/06/18.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case DecodingError
}

class WeatherSerivce {
    let apiKey = "Your API key"
    
    func getWeather(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)")
        guard let url = url else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                print(weatherResponse)
                completion(.success(weatherResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.DecodingError))
            }
        }.resume() // 이 dataTastk 시작
    }
    
    
}
