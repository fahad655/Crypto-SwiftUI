//
//  CryptoViewModel.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import Foundation
import SwiftUI
import Combine

class AssetViewModel : ObservableObject {
    
    
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    let didChange = PassthroughSubject<Void, Never>()
    
    var selectedAssetSymbol = CryptoData(id: UUID(),
                                                    description: "COINBASE BTC/USD",
                                                    displaySymbol: "BTC",
                                                    symbol: "COINBASE:BTC-USD") {
        didSet {
            connect()
        }
    }
    
    @Published var price: String = "-"
    
    private var cancellable: AnyCancellable?
    

    var priceResult: String = "" {
        didSet {
            didChange.send()
        }
    }
    
    
    init() {
        
        cancellable = AnyCancellable($price
                                            .debounce(for: 0.0, scheduler: DispatchQueue.main)
                                            .removeDuplicates()
                                            .assign(to: \.priceResult, on: self))
        
    }
    
    func connect() {
        
        price = "-"
        stop()
        webSocketTask = urlSession.webSocketTask(with: Constants.SocketUrl)
        webSocketTask?.resume()
        
        sendMessage()
        receiveMessage()
    }
    
    func stop() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    private func sendMessage() {
        
        let string = "{\"type\":\"subscribe\",\"symbol\":\"\(selectedAssetSymbol.symbol)\"}"
        
        let message = URLSessionWebSocketTask.Message.string(string)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket couldn’t send message because: \(error)")
            }
        }
    }
    
    private func receiveMessage() {
        
        webSocketTask?.receive {[weak self] result in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.price = "0"
                }
                print("Error in receiving message: \(error)")
            case .success(.string(let str)):
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(APIResponse.self, from: Data(str.utf8))
                    DispatchQueue.main.async{ [weak self] in
                        
                        if let self = self {
                            
                            self.price = "\(result.data.first?.price ?? 0)"
                        }
                    }
                } catch  {
                    DispatchQueue.main.async{
                        self?.price = "0"
                    }
                    print("error is \(error.localizedDescription)")
                }
                
                self?.receiveMessage()
                
            default:
                print("default")
            }
        }
    }
    
    deinit {
        
        cancellable = nil
    }
    
}
