//
//  URLSession.swift
//  foodie
//
//  Created by Konrad Groschang on 04/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

extension URLSession {

    convenience init(
        configuration: URLSessionConfiguration = .default,
        timeout: Int
    ) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        self.init(configuration: configuration)
    }
}


extension URLSession {

    static let extended = URLSession(timeout: 50)
}
