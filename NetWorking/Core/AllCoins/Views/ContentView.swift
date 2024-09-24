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
                Text(coin.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
