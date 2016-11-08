//
//  ConfigurationManager.swift
//  TestServer
//
//  Created by Kerem Karatal on 9/24/16.
//
//

import Foundation
import PerfectHTTP

public struct ConfigurationManager {
    let configurationReader: ConfigurationReader
    
    init(reader: ConfigurationReader) {
        self.configurationReader = reader
    }
    
    public func configureRoutes() -> Routes {
        let configuration = configurationReader.read()
        
        return RouteHandler(routeConfigurations: configuration.routeConfigurations).configureRoutes()
    }
    
}
