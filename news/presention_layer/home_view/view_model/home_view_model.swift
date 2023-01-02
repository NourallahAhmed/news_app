//
//  home_view_model.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
import Network

class HomeViewModel{
    
    // instance from usecase
    
    private var homeUseCase : HomeUseCase = HomeUseCase();
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private let monitor = NWPathMonitor()
    var numOfArticles = 0;
    var newsArticles = Array<Article>();
    
    func getNews(complition: @escaping (([Article]) -> Void )) {
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
        if pathUpdateHandler.status == .satisfied {
        DispatchQueue.global().async {
            self?.homeUseCase.getEveryThing { newsRequest in
                DispatchQueue.main.async{
                    complition(newsRequest?.articles ?? Array<Article>());
                    self?.numOfArticles = newsRequest?.totalResults ?? 0;
                    self?.newsArticles = newsRequest?.articles ?? [];
                    print(self?.numOfArticles)}
                
                }
            }
        }
        else{
                DispatchQueue.main.async {
//                      self?.homeView.checkNetwork()
//                      self?.homeView.stopIndicator()
                    
                }
            }
        }//monitor
        self.monitor.start(queue: queue)
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
