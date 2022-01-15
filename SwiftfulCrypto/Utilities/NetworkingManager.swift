//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 1/14/22.
//

import Foundation
import Combine

class NetworkingManager{
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        
        //Replaced type
        //Publishers.ReceiveOn<Publishers.TryMap<Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>, DispatchQueue>
        //With type
        // AnyPublisher<Data, Error>
        
        //To do this:
        // 1. Make AnyPublisher<Data, Error> the return type of the func.
        //2. Put .eraseToAnyPublisher() on the func itself. 
        
        //Original func:
        
//        static func download(url: URL) -> Publishers.ReceiveOn<Publishers.TryMap<Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>, DispatchQueue> {
        
        //temp was used and set = to URLSession to get the return type of URLSession that is above.
        //Hold option and click on temp to see it's type.
        //That is the type that this function returns.
        
        //let temp = URLSession.shared...
        
        return URLSession.shared.dataTaskPublisher(for: url)
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
            //
            .eraseToAnyPublisher()
    }
}
