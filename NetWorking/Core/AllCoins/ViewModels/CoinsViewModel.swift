//
//  CoinsViewModel.swift
//  NetWorking
//
//  Created by MacBook Air on 17/09/2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMassage: String?
    
    private let service = CoinDataService()
    init() {
//        fetchPrice(coin: "bitcoin")
        fetchCoins()
    }
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
            
        }
    }
    
}
