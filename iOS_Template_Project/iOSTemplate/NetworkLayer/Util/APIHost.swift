//
//  ApiHost.swift
//  VictorOnlineParent
//
//  Created by Derrick on 2020/6/10.
//  Copyright © 2020 Victor. All rights reserved.
//

import Foundation

class APIHost: NSObject {
    
    enum AppBuildType: Int {
        case Dev
        case Uat
        case Release
    }
    
    enum BackgroundServerType: Int {
        case BaseClient
        case H5PageClient
        case FileClient
    }
    static var BaseClients = ["Dev": "https://admin-api.dev.victor.vip",
                              "Uat": "https://Uat-admin-api.victor.vip",
                              "Release": "https://admin-api.victor.vip"]
    
    static var H5PageClients = ["Dev": "https://h5.dev.victor.vip",
                                "Uat": "https://Uat-h5.victor.vip",
                                "Release": "https://h5.victor.vip"]
    
    static var FileClients = ["Dev": "https://file.dev.victor.vip",
                                "Uat": "https://Uat-file.victor.vip",
                                "Release": "https://file.victor.vip"]
    
    
    static func getUrlAddress(buildType:AppBuildType,serverType:BackgroundServerType) -> String {
        var buildType = "\(buildType)"
        if let current = Defaults.shared.get(for: .currentBuildType) {
            buildType = current
        }else {
            buildType = "\(buildType)"
        }
        
        var address: String
        switch serverType {
        case .BaseClient :
            address = BaseClients[buildType]!
        case .H5PageClient:
            address = H5PageClients[buildType]!
        case .FileClient:
            address = FileClients[buildType]!
        }
        return address
    }
    
    static func getUrlByServerType(serverType: BackgroundServerType) -> String {
        #if DEBUG
        return getUrlAddress(buildType: .Dev,serverType: serverType)
        #elseif Uat
        return getUrlAddress(buildType: .Uat,serverType:serverType)
        #else  //REALEASE
        return getUrlAddress(buildType: .Release, serverType: serverType)
        #endif
    }
    @objc static var BaseUrl: String {
        return getUrlByServerType(serverType: .BaseClient)
    }
    @objc static var FileBaseUrl: String {
        return getUrlByServerType(serverType: .FileClient)
    }
    @objc static var H5PageUrl:String {
        return getUrlByServerType(serverType: .H5PageClient)
    }
   
    static var allBuildTypeCases:[AppBuildType] {
        return [.Dev,.Uat,.Release]
    }
    
}

extension APIHost.AppBuildType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Dev:
            return "Dev"
        case .Uat:
            return "Uat"
        case .Release:
            return "Release"
        }
    }
    static var currentBuildType:String {
        #if DEBUG
        return self.Dev.description
        #elseif Uat
        return self.Uat.description
        #else  //REALEASE
        return self.Release.description
        #endif
    }
}

