//
//  Configuration.swift
//  TestServer
//
//  Created by Kerem Karatal on 9/17/16.
//
//

import Foundation

public struct Configuration {
    enum Error:String {
        case InitializationSuccessful
        case IncorrectJSON
        case InitializedWithNoData
        case NoRoutesDefined
        case ConfigurationFileMissing
    }
    
    let routeConfigurations:[RouteConfiguration]
    var errorCode:Error = Error.InitializationSuccessful
    
    init() {
        self.errorCode = Error.InitializedWithNoData
        self.routeConfigurations = []
    }
}

extension Configuration {
    init(jsonData: Any) {
        guard jsonData is Dictionary<String, Any> else {
            self.routeConfigurations = []
            self.errorCode = Error.IncorrectJSON
            return
        }
        
        let configuration = jsonData as! Dictionary<String, Any>
        
        var routes:[RouteConfiguration] = []
        if let routeList = configuration["routes"] as? [Dictionary<String, String>] {
            for routeInfo in routeList {
                if let route = RouteConfiguration(jsonData: routeInfo) {
                    routes.append(route)
                }
            }
        }
        
        if routes.isEmpty {
            self.errorCode = Error.NoRoutesDefined
        }
        
        self.routeConfigurations = routes
    }
}

