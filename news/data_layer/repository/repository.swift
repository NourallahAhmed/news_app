//
//  repository.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
class Repository : BaseRepository{
  
    
    var remoteDataSource = RemoteDataSource();
    
    
    func getEveryThing(complitionHandler : @escaping (NewsRequest?) -> Void){
        remoteDataSource.getEveryThing  { (result) in
            do{
                
                guard let request = try? result.get() else {
                    return ;
                }
                complitionHandler(request)
                
            }

            
        }
    }
    func getTopHeaders(complitionHandler: @escaping (NewsRequest?) -> Void) {
        remoteDataSource.getTopHeadLines { (result) in
            do{
                
                guard let request = try? result.get() else {
                    return ;
                }
                complitionHandler(request)
                
            }

            
        }
    }
    
    func getSearch(query: String, complitionHandler: @escaping (NewsRequest?) -> Void) {
        remoteDataSource.getSearch(topic: Topics.everyThing, query: query){ (result) in
            do{
                
                guard let request = try? result.get() else {
                    return ;
                }
                complitionHandler(request)
                
            }

            
        }
    }
    
    
    
}
