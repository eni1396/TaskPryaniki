//
//  ApiManager.swift
//  TaskPryaniki
//
//  Created by Nikita Entin on 28.07.2021.
//

import Foundation
import Alamofire

struct ApiManager {
    
    func fetch<T: Codable>(completion: @escaping (T) -> Void, errorHandler: @escaping (AFError?) -> Void) {
        let path = "https://pryaniky.com/static/json/sample.json"
        AF.request(path).response { dataResponse in
            guard let data = dataResponse.data,
                  let data = try? JSONDecoder().decode(T.self, from: data) else { return }
            completion(data)
            if let error = dataResponse.error {
                print(error.localizedDescription)
                errorHandler(error)
            }
        }
    }
}

