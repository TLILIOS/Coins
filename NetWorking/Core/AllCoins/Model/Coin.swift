//
//  Coin.swift
//  NetWorking
//
//  Created by MacBook Air on 24/09/2024.
//

import Foundation
struct Coin: Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double
    let marketCapRank: Int
    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
