//
//  remote_data_source.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
protocol BaseRemoteDataSource{
    func getEveryThing(complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void) 
    
    func getTopHeadLines(complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void)
    
    func getSearch( topic: Topics ,query : String ,complitionHandler : @escaping (Result<NewsRequest?, NSError>) -> Void)
}
class RemoteDataSource : BaseRemoteDataSource{
    
    var networkClient : NetworkProtocol = NetworkClient();
    
    func getEveryThing(complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        networkClient.getEveryThing { (result ) in
                complitionHandler(result)
        }
    }
    
    func getTopHeadLines(complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        networkClient.getTopHeadLines { (result ) in
                complitionHandler(result)
        }
    }
    
    func getSearch(topic: Topics, query: String, complitionHandler: @escaping (Result<NewsRequest?, NSError>) -> Void) {
        networkClient.getSearch(topic: topic, query: query) { (result ) in
                complitionHandler(result)
        }

    }
    
    
}
