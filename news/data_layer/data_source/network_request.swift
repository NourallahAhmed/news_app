//
//  network_request.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation
//import Alamofire

enum NetworkRequest{
    case search(query:String);
    case headlines;
    case everyThing;
}

extension NetworkRequest : TargetType {
    var baseURL: String {
        switch self {
            default : return ApiConstants.baseURL
            
        }
    }
    
    var path: String {
        switch self {
        case .everyThing :
            
            return ApiConstants.everyThing + ApiConstants.apiKey;
        
        case .headlines :
            return ApiConstants.headLines + ApiConstants.apiKey;


        case .search(let query) :
            return ApiConstants.search(topic: "everything" , query : query);

            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .everyThing :
            
            return .get;
        
        case .headlines :
            return .get;


        case .search :
            return .get;
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:

            return ["apiKey" : ApiConstants.apiKey]
        }
    }
}
