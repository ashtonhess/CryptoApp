//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Ashton Hess on 1/14/22.
//

import Foundation
import Combine

class NetworkingManager{
    
    //enum for custom errors to be called easily.
    enum NetworkingError: LocalizedError{
        
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self{
            case .badURLResponse(url: let url): return "[🚨] Bad response from URL: \(url)"
            case .unknown: return "[🚨] Unknown error occured."
            }
        }
    }
    
/**download function in NetworkingManager
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
 **/
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            //
            .eraseToAnyPublisher()
    }
    
    //Checking for a valid response, if data is good or not.
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        //testing error Throw
        //throw NetworkingError.badURLResponse(url: url)

        guard let response = output.response as? HTTPURLResponse,
                response.statusCode>=200 && response.statusCode < 300 else { //200 range for statusCodes mean successful response
                    //This was Throwing a generic error, replaced with better error messages.
//                    throw URLError(.badServerResponse)
                    
                    throw NetworkingError.badURLResponse(url: url)
                }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        //If there is an error it will print here
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
