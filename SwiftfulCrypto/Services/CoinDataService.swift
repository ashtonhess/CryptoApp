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
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
        //Checking for a valid response, if data is good or not.
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                        response.statusCode>=200 && response.statusCode < 300 else { //200 range for statusCodes mean successful response
                            throw URLError(.badServerResponse)
                        }
                return output.data
            }
            .receive(on: DispatchQueue.main)
        //If the data is good we are trying to decode it into CoinModels
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    break
                //If there is an error it will print here
                case .failure(let error):
                    print(error.localizedDescription)
                }
                //If there is no error, we are appending the returnedCoins to our allCoins and canceling subscription bc we are done getting data.
            } receiveValue: { [weak self](returnedCoins) in
                //Appending the response from the URL to allCoins var
                self?.allCoins = returnedCoins
                
                //cancels call to API, after getting the coins we dont need to keep this open
                self?.coinSubscription?.cancel()
            }
            

        
    }
}
