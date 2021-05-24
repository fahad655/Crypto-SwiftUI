//
//  SelectAssetView.swift
//  Crypto-SwiftUI
//
//  Created by Fahad Shafique on 5/24/21.
//

import SwiftUI

struct SelectAssetView: View {
    
    let assetArray : [CryptoData]
    let service : AssetViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
       
        VStack{
            List {
                ForEach(assetArray){ asset in
                    VStack {
                        Text(asset.displaySymbol).fontWeight(.semibold).font(.system(size: 20))
                        Text(asset.description).fontWeight(.light).font(.system(size: 8))
                        Button("", action: {
                            self.service.selectedAssetSymbol = asset
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }.frame(alignment: .leading)
            .navigationBarTitle(Text("COINBASE ASSETS"), displayMode: .automatic )
        }
    }
}
