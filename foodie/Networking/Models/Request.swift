//
//  Request.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

class Request<T:Codable>: @unchecked Sendable {

     let endpoint: Endpoint
     let headers: [String: String]?
    
    init(endpoint: Endpoint, headers: [String: String]? = nil) {
        self.endpoint = endpoint
        self.headers = headers
    }
}


extension Request: CustomStringConvertible {
    var description: String {
        String(describing: endpoint.path)
    }
}
