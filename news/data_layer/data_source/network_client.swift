//
//  network_client.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
protocol NetworkProtocol{
    func getEveryThing(complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void)
    
    func getTopHeadLines(complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void)
    
    func getSearch( topic: Topics ,query : String ,complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void)
}

class NetworkClient : BaseAPI<NetworkRequest> , NetworkProtocol{
    
    static var networkClient =  NetworkClient()
    
    func getEveryThing(complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        self.fetchData(target: NetworkRequest.everyThing, responseClass: NewsRequest.self) { (result) in
            complitionHandler(result)
        }
    }
    
    func getTopHeadLines(complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        self.fetchData(target: NetworkRequest.headlines, responseClass: NewsRequest.self) { (result) in
            complitionHandler(result)
        }
    }
    
    func getSearch(topic: Topics, query: String, complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        self.fetchData(target: NetworkRequest.search(query: query), responseClass: NewsRequest.self) { (result) in
            complitionHandler(result)
        }
    }
    
    
}
