//
//  NetworkManager.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import Foundation
import UIKit

struct NetworkManager {
    public typealias ModelCompletionHandler<T: Codable> = (T?, Error?) -> Void
    
    public func downloadData <T: Decodable> (classType: T.Type,
                                             settingsKey: String,
                                             substitution: String,
                                             completion: ((T?, [String: Any]?, Error?) -> Void)?) {
        guard let url = URL(string: settingsKey + substitution) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion?(nil, nil, error)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(classType.self, from: data)
                DispatchQueue.main.async {
                    completion?(decodedData, nil, error)
                }
            } catch let decodeError {
                completion?(nil, nil, decodeError)
            }
        }.resume()
    }
}

