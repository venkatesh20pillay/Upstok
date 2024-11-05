//
//  NetworkManager.swift
//  Upstok
//
//  Created by Venkatesh Pillay on 05/11/24.
//

import Foundation

class NetworkManager {
    static func fetchApi<T: Decodable>(type: T.Type, urlString: String, completionHandler: @escaping (T)-> Void) {
        if let url = URL(string: urlString) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  if let stockData = try? JSONDecoder().decode(T.self, from: data) {
                      completionHandler(stockData)
                  }
               }
           }.resume()
        }
    }
}
