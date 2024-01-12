//
//  URL.swift
//  foodie
//
//  Created by Konrad Groschang on 27/07/2023.
//

import Foundation

extension URL {

    init?(string: String?) {
        guard let string else { return nil }
        guard let url = URL(string: string) else { return nil }
        self = url
    }

}

extension URL {

    init?(enviroment: APIEndpoint, endpoint: Endpoint) {
        guard let url = URLComponents(enviroment: enviroment,
                                      endpoint: endpoint).url
        else {
            return nil
        }

        self = url
    }

}
