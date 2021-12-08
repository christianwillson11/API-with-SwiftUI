//
//  DetailView.swift
//  CoinGecko
//
//  Created by Willson on 06/12/21.
//

import SwiftUI

struct DetailView: View {
    
    var data: CoinData!
    
    var body: some View {
        VStack {
            URLImage(urlString: data.image)
                .padding(.top, 20)
            VStack {
                Text("Coin Data")
                    .padding(.bottom, 10)
                    .font(.largeTitle)
                HStack(alignment: .top) {
                    Text("Name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(data.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                HStack(alignment: .top) {
                    Text("Symbol")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(data.symbol))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                HStack(alignment: .top) {
                    Text("Current Price")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(data.current_price))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                
                HStack(alignment: .top) {
                    Text("Price Change 24 Hour")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(data.price_change_24h))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
            }.padding(.top)
            Spacer()
        }.padding(.horizontal, 8)
        .navigationTitle(data.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: DummyData.result.first!)
    }
}
