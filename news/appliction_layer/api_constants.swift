//
//  api_constants.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
class ApiConstants{
    static  let baseURL = "https://newsapi.org/v2";
    static  let everyThing = "/everything?q=bitcoin";
    static  let headLines = "/top-headlines?q=football";
    static  let apiKey = "&apiKey=3957c867747c4216a9e3bc575c9bd0aa";
//&apiKey=
    static func search(topic:String,query : String) -> String {
        return "/"+topic+"?q="+query+apiKey; //todo topic means (everyThing or topheadlines)
    };
}
