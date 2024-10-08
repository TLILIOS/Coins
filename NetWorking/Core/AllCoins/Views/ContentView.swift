//
//  ContentView.swift
//  NetWorking
//
//  Created by MacBook Air on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        List {
            ForEach (viewModel.coins) { coin in
                HStack(spacing: 15) {
                    Text("\(coin.marketCapRank)")
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(coin.name)
                            .bold()
                        
                        Text("\(coin.symbol.uppercased())")
                        
                    }
                }
                .font(.footnote)
                
            }
        }
        .overlay {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
