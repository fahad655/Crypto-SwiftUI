//
//  WebServiceHelper.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation

class ServiceLayer {
    
    class func request<T: Codable>(completion: @escaping (Result<T, Error>) -> ()) {
        
        
        var urlRequest = URLRequest(url: Constants.APIUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                    print(error?.localizedDescription ?? "")
                }
                return
            }
            
            guard response != nil, let data = data else {
                return
            }
            
            do {
                
                if let statusCode = (response as?  HTTPURLResponse)?.statusCode {
                    
                    if (400 ... 405).contains(statusCode) {
                        
                        let error = NSError(domain:"", code:statusCode, userInfo:[ NSLocalizedDescriptionKey:"Not found"])
                        
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    if (500 ... 505).contains(statusCode) {
                        
                        let error = NSError(domain:"", code:statusCode, userInfo:[ NSLocalizedDescriptionKey: NSLocalizedString("Server is not responding", comment: "")])
                        
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    
                    if (200 ... 204).contains(statusCode) {
                        
                        let responseObject =  try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            
                            completion(.success(responseObject))
                        }
                    }
                }
            }
            catch (let error) {
                
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
        dataTask.resume()
        
    }
}

