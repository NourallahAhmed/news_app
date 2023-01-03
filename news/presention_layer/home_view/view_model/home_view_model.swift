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
    
    private var homeUseCase : HomeUseCaseProtocol = HomeUseCase();
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private let monitor = NWPathMonitor()
    var newsArticles = Array<Article>();
    
    func getNews(complition: @escaping (([Article]) -> Void )) {
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
        if pathUpdateHandler.status == .satisfied {
        DispatchQueue.global().async {
            self?.homeUseCase.getEveryThing { newsRequest in
                DispatchQueue.main.async{
                    self?.newsArticles = newsRequest?.articles ?? [];
                    
                    complition(newsRequest?.articles ?? Array<Article>());
                    }
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
    
    
    
    
    
    func getSearch(query : String , complition: @escaping (([Article]) -> Void )) {
        
        
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
            if pathUpdateHandler.status == .satisfied {
            DispatchQueue.global().async {
                self?.homeUseCase.getSearch(query: query) { newsRequest in
                    self?.newsArticles = newsRequest?.articles ?? [];

                    complition(newsRequest?.articles ?? Array<Article>());
                }
                
                }
            }
            else{
                    DispatchQueue.main.async {
    //                      self?.homeView.checkNetwork()
    //                      self?.homeView.stopIndicator()
                        
                    }
                }
              
        }
        self.monitor.start(queue: queue)

    }
}
