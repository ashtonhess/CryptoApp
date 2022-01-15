//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 1/14/22.
//

import Foundation
import Combine

/*CoinGeko URL 1
 //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 */
class CoinDataService{
    
    //Anything subscribed to this publisher var is notified when changes happen. 
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    
    init(){
        
        getCoins()
        
    }
    
    
    private func getCoins(){
        
        //Going to the CoinGecko URL
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        //Getting data from the URL
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
        //.sink returns type Subscribers.Completion<Error>
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
        
    }
}
