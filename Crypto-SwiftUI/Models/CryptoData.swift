//
//  CryptoData.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation

struct CryptoData: Codable,Identifiable,Equatable {
    
    public var id = UUID.init()
    public var description : String
    public var displaySymbol :String
    public var symbol : String
    
    private enum CodingKeys: String, CodingKey {
           case description, displaySymbol,symbol
       }
}
