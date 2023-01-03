//
//  home_use_case.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation

protocol HomeUseCaseProtocol{
    func getEveryThing(complitionHandler : @escaping (NewsRequest?) -> Void)
    func getSearch( query :String ,complitionHandler : @escaping (NewsRequest?) -> Void)

}
class HomeUseCase : HomeUseCaseProtocol{
    //instance from repo
    
    var repo : BaseRepository = Repository();
 

    func getEveryThing(complitionHandler: @escaping (NewsRequest?) -> Void) {
        repo.getEveryThing { newsRequest in
            complitionHandler(newsRequest);
        }
    }
    
   
    
    func getSearch(query: String, complitionHandler: @escaping (NewsRequest?) -> Void) {
        repo.getSearch(query: query) { newsRequest in
            complitionHandler(newsRequest);
        }
    }
    
    
}
