//
//  CoinDataService.swift
//  NetWorking
//
//  Created by MacBook Air on 23/09/2024.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&price_change_percentage=24h"
    
    func fetchCoins() async throws -> [Coin]{
        guard let url = URL(string: urlString) else { return [] }
        print("Fetching coins")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
        } catch {
            print("Error \(error.localizedDescription)")
            return []
        }
      
    }
    
}


//MARK: - Completion Handlers
extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print(error)
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                //                    self.errorMassage = error.localizedDescription
                return
            }
            
//            print("Debug: Response code is \(httpResponse.statusCode)")
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return }
            guard let price = value["usd"] else { return }
            //                self.coin = coin.capitalized
            //                self.price = "$\(price)"
            print("Price: \(price)")
            completion(price)
            
        }.resume()
    }
}
