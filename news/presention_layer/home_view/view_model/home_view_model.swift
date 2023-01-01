//
//  home_view_model.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation

class HomeViewModel{
    
    // instance from usecase
    
    var homeUseCase : HomeUseCase = HomeUseCase();
    
    func getNews(complition: @escaping (([Article]) -> Void )) {
        homeUseCase.getEveryThing { newsRequest in
            complition(newsRequest?.articles ?? Array<Article>());
        }
    }
    
    
    func getTopHeaders(complition: @escaping (([Article]) -> Void )) {
        homeUseCase.getTopHeaders { newsRequest in
            complition(newsRequest?.articles ?? Array<Article>());
        }
    }
    
    
    func getSearch(query : String , complition: @escaping (([Article]) -> Void )) {
        homeUseCase.getSearch(query: query) { newsRequest in
            complition(newsRequest?.articles ?? Array<Article>());
        }
    }
}
