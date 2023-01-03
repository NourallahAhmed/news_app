//
//  headlines_view_model.swift
//  news
//
//  Created by NourAllah Ahmed on 03/01/2023.
//

import Foundation
import Network
class HeadLinesViewModel{
    private var headLinesUseCase : HeadLinesUseCaseProtocol = HeadlinesUseCase();
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private let monitor = NWPathMonitor()
    
    var numOfArticles = 0;
    var newsArticles = Array<Article>();
    
    func getHeadLines(complition: @escaping (([Article]) -> Void )){
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
        if pathUpdateHandler.status == .satisfied {
            DispatchQueue.global().async {
                self?.headLinesUseCase.getTopHeaders { newsRequest in
                    DispatchQueue.main.async{
                        complition(newsRequest?.articles ?? Array<Article>());
                        self?.numOfArticles = newsRequest?.totalResults ?? 0;
                        self?.newsArticles = newsRequest?.articles ?? [];
                    
                    }
                }
            }
        }else{
            
            }
        }
        self.monitor.start(queue: queue)

    }
}
