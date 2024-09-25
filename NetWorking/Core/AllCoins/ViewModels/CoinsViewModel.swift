//
//  CoinsViewModel.swift
//  NetWorking
//
//  Created by MacBook Air on 17/09/2024.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
    init() {
        Task { await fetchCoins() }
    }
    
    func fetchCoins() async {
        do {
            let fetchedCoins = try await service.fetchCoins()
            DispatchQueue.main.async { [weak self] in
                self?.coins = fetchedCoins
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        
        }
    }
    
    func fetchCoinsWithCompletionHandler() {
        service.fetchCoinsWithResult { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
