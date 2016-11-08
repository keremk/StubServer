//
//  RouteHandler.swift
//  TestServer
//
//  Created by Kerem Karatal on 9/17/16.
//
//

import Foundation
import PerfectHTTP

public struct RouteHandler {
    let routeConfigurations: [RouteConfiguration]
    
    func handleGETRequest(request: HTTPRequest, _ response: HTTPResponse) {
        guard let routeConfiguration = findRouteConfiguration(request: request) else {
            response.setHeader(.contentType, value: "text/html")
            response.appendBody(string: "<html><title>Error</title><body>No configuration found!?</body></html>")
            response.completed()
            return
        }
        
        guard let responseDataFile = routeConfiguration.responseDataFile else {
            response.setHeader(.contentType, value: "text/html")
            response.appendBody(string: "<html><title>Error</title><body>No file setup</body></html>")
            response.completed()
            return
        }

        let fileManager = FileManager.default
        let fullDataFilePath = fileManager.currentDirectoryPath + "/" + responseDataFile
        if  let jsonBodyData = fileManager.contents(atPath: fullDataFilePath),
            let jsonBody:String = String(data: jsonBodyData, encoding: .utf8) {
            
            response.setHeader(.contentType, value: "application/json")
            response.appendBody(string: jsonBody)
            response.completed()
            
        } else {
            response.setHeader(.contentType, value: "text/html")
            response.appendBody(string: "<html><title>Error</title><body>No file setup</body></html>")
            response.completed()
        }
        
    }
    
    func handlePOSTRequest(request: HTTPRequest, _ response: HTTPResponse) {
        
    }
    
    private func findRouteConfiguration(request:HTTPRequest) -> RouteConfiguration? {
        var routeConfiguration: RouteConfiguration?
        
        for configurationEntry in routeConfigurations {
            if configurationEntry.routeMatcher.contains(request.path) {
                routeConfiguration = configurationEntry
                break;
            }
        }
        
        return routeConfiguration
    }
}

extension RouteHandler {
    func configureRoutes() -> Routes {
        var routes = Routes()
        
        for routeConfiguration in routeConfigurations {
            switch (routeConfiguration.handlerType) {
            case RouteConfiguration.HandlerType.GET:
                routes.add(method: HTTPMethod.get, uri: routeConfiguration.routeMatcher, handler: handleGETRequest)
            case RouteConfiguration.HandlerType.POST:
                routes.add(method: HTTPMethod.post, uri: routeConfiguration.routeMatcher, handler: handlePOSTRequest)
            }
        }
        return routes
    }
}
