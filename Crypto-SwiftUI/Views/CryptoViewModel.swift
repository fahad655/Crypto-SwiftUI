//
//  CryptoViewModel.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation
import Combine

class CryptoViewModel : ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    var assets = [CryptoData]()
    
    private var cancellable: AnyCancellable? = nil
    
    var assetsList: String = "" {
        didSet {
            didChange.send()
        }
    }
    
    init() {
        self.fetchData()
    }

    private func fetchData() {
        
        ServiceLayer.request() { (result: Result<[CryptoData], Error>) in
            
            switch result {
            
            case .success(let data):
                
                self.assets = [CryptoData]()
                
                 data.filter { $0.symbol.contains("USD") }.forEach({ cData in
                    
                    let cryptoData  = CryptoData(id:UUID(),
                                                 description: cData.description,
                                                 displaySymbol: cData.displaySymbol.replacingOccurrences(of: "/USD", with: ""),
                                                 symbol:  cData.symbol)
                    
                    self.assets.append(cryptoData)
                })
              
                
            case .failure(_):
                print("something is here at failure ")
            }
        }
    }
}

