//
//  APIResponse.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation


struct APIResponse: Codable {
    
    var data: [AssetValueData]
    var type : String
    
    private enum CodingKeys: String, CodingKey {
        case data, type
    }
}
