//
//  NetworkService.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation

class NetworkService {
    func invokeNetworkService(for url: URL, completion: @escaping (Result<[Product], Error>) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let responseModels = try decoder.decode([ProductResponse].self, from: data)
                    let domainModels = responseModels.map { Product(response: $0) }
                    completion(.success(domainModels))
                } catch {
                    completion(.failure(Self.anyError()))
                }
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(Self.anyError()))
            }
            
            if error != nil {
                completion(.failure(Self.anyError()))
            }
        }.resume()
    }
    
    static func anyError() -> NSError {
        NSError(domain: "", code: 0)
    }
}
