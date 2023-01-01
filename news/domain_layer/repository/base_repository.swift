//
//  base_repository.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
protocol BaseRepository{
    
    func getEveryThing(complitionHandler : @escaping (NewsRequest?) -> Void)
    func getTopHeaders(complitionHandler : @escaping (NewsRequest?) -> Void)
    func getSearch(query : String , complitionHandler : @escaping (NewsRequest?) -> Void)
}
