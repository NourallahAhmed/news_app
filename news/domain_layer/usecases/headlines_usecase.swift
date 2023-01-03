//
//  headlines_usecase.swift
//  news
//
//  Created by NourAllah Ahmed on 03/01/2023.
//

import Foundation
protocol HeadLinesUseCaseProtocol {
    func getTopHeaders(complitionHandler : @escaping (NewsRequest?) -> Void)

}
class HeadlinesUseCase : HeadLinesUseCaseProtocol{
    var repo : BaseRepository = Repository();

    func getTopHeaders(complitionHandler: @escaping (NewsRequest?) -> Void) {
        repo.getTopHeaders { newsRequest in
            complitionHandler(newsRequest);
        }
    }
}
