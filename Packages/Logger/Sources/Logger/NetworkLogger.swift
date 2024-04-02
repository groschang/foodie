//
//  NetworkLogger.swift
//  
//
//  Created by Konrad Groschang on 27/01/2023.
//

import Foundation

public struct NetworkLogger {
    
    public static func log(request: URLRequest, response: URLResponse, data: Data, onLevel level: Logger.Level = .verbose) {
        Logger.log("\nBEGIN Request\n", onLevel: level)
        defer { Logger.log("\nEND Request\n", onLevel: level) }
        log(request: request, onLevel: level)
        log(response: response, onLevel: level)
        log(data: data, onLevel: level)
    }

    public static func log(request: URLRequest, onLevel level: Logger.Level = .verbose) {
        Logger.log("\(request: request)", onLevel: level)
    }
    
    public static func log(response: URLResponse, onLevel level: Logger.Level = .verbose) {
        Logger.log("\(response: response)", onLevel: level)
    }
    
    public static func log(data: Data, onLevel level: Logger.Level = .verbose) {
        Logger.log("\(data: data)", onLevel: level)
    }
}
