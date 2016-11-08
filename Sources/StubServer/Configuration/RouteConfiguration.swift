//
//  RouteConfig.swift
//  TestServer
//
//  Created by Kerem Karatal on 9/17/16.
//
//

import Foundation

public struct RouteConfiguration {
    enum HandlerType:String {
        case GET
        case POST
    }
    
    let routeMatcher: String
    let responseDataFile: String?
    let handlerType: HandlerType
}

extension RouteConfiguration {
    init?(jsonData: Dictionary<String, String>) {
        guard   let routeMatcher = jsonData["routeMatcher"],
                let handlerTypeString = jsonData["handlerType"],
                let handlerType = HandlerType(rawValue: handlerTypeString) else {
            return nil
        }
        
        self.responseDataFile = jsonData["responseDataFile"]
        self.routeMatcher = routeMatcher
        self.handlerType = handlerType
    }
}
