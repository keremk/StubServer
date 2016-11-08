//
//  ConfigurationReader.swift
//  TestServer
//
//  Created by Kerem Karatal on 9/24/16.
//
//

import Foundation

public protocol ConfigurationReader {
    func read() -> Configuration
}

public struct DefaultConfigurationReader : ConfigurationReader {
    let filename = "/route_config.json"
    
    public func read() -> Configuration {
        let fileManager = FileManager.default
        let fullConfigurationPath = fileManager.currentDirectoryPath + filename
        let configurationData = fileManager.contents(atPath: fullConfigurationPath)
     
        return parse(configurationData: configurationData)
    }

    private func parse(configurationData:Data?) -> Configuration  {
        guard let configurationData = configurationData else {
            var configuration = Configuration()
            configuration.errorCode = Configuration.Error.ConfigurationFileMissing
            return configuration
        }
        
        let configJSON = try! JSONSerialization.jsonObject(with: configurationData, options: [])
        
        return Configuration(jsonData: configJSON)
    }
}
