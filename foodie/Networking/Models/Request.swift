//
//  Request.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//

class Request<T:Codable> {

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
