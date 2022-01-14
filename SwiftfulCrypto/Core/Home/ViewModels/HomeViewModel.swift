//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 1/10/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    //array of coinmodel data for the screen with all coins
    //This allCoins var in the vm is going to subscribe to the allCoins var in the CoinDataService.
    //Published vars have subscribers. When a published var is updated, all of the subscribing vars are updated with it.
    @Published var allCoins: [CoinModel] = []
    //array of coinmodel data for our portfolio screen
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        addSubscribers()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
    }
    
    
    func addSubscribers(){
        //Using $allCoins with $ because this allCoins is the publisher
        //This is "subscribing to the dataService.$allCoins in the CoinDataService class.
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}
