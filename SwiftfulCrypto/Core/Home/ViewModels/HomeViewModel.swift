//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 1/10/22.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    //array of coinmodel data for the screen with all coins
    @Published var allCoins: [CoinModel] = []
    //array of coinmodel data for our portfolio screen
    @Published var portfolioCoins: [CoinModel] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
    
}
