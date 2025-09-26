//
//  HttpStatusCode.swift
//  foodie
//
//  Created by Konrad Groschang on 20/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

struct HttpStatusCode {

    static let information = 100...199

    static let successful = 200...299

    static let redirection = 300...399

    static let clientError = 400...499
    
    static let serverError = 500...599
}
