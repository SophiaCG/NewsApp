//
//  NetworkManager.swift
//  News-App
//
//  Created by SCG on 10/25/21.
//

import Foundation

class NetworkManager {

    let apiKey = "API-KEY-HERE"
    
    func getArticles(completion:@escaping (Articles) -> ()) {
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                print("ERROR: \(String(describing: error))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Articles.self, from: data!)
//                print("RESULTS: \(results)")
                
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Error: ", error)
            }

        }
        task.resume()
    }

}

