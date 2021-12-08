//
//  CoinData.swift
//  CoinGecko
//
//  Created by Willson on 05/12/21.
//

import Foundation

struct CoinData: Decodable, Hashable {
//    var id = UUID()
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Float
    let price_change_24h: Float
}

struct DummyData {
    static let result = [
        CoinData(id: "123", symbol: "test", name: "Bitcoin", image: "http://www.google.com", current_price: 12, price_change_24h: 12.0)
    ]
}
