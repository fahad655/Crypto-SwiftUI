//
//  ContentView.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var socketService = AssetViewModel()
    @State private var showingSheet = false
    var service = CryptoViewModel()
    
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Text("$" + socketService.priceResult)
                    .font(.system(size: 60))
                    .navigationBarTitle(Text(socketService.selectedAssetSymbol.displaySymbol), displayMode: .large )
                    .toolbar {
                            Button("Edit") {
                                showingSheet.toggle()
                            }
                    }
                    .sheet(isPresented: $showingSheet) {
                        SelectAssetView(assetArray: service.assets,
                                                     service: self.socketService)
                        }
                
                
            }.onAppear {
                self.socketService.connect()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
