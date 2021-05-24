//
//  AssetData.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation


struct AssetValueData : Codable{
    
    public var price: Float
    
    private enum CodingKeys: String, CodingKey {
        case price = "p"
    }
}
