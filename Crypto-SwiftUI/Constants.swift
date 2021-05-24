//
//  Constants.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation

struct Constants {
    
    static private let ApiToken  = "c2lid32ad3iacncll4m0"
    static private let baseURL =  "finnhub.io/"
    
    static var SocketUrl : URL {
        
        guard let url = URL(string: "wss://ws.\(Constants.baseURL)?token=\(Constants.ApiToken)")  else {
            fatalError("URL to fetch socket data should be valid for this application")
        }
        return url
        
    }

    static var APIUrl : URL {
      
        guard let url = URL(string: "https://\(Constants.baseURL)api/v1/crypto/symbol?exchange=COINBASE&token=\(Constants.ApiToken)")  else {
            fatalError("URL to fetch Api data should be valid for this application")
        }
        return url
    }
    
}
