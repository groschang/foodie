//
//  String+NetworkLogger.swift
//  
//
//  Created by Konrad Groschang on 10/06/2023.
//

import Foundation

public extension String.StringInterpolation {

    mutating func appendInterpolation(request: URLRequest) {
        var output = [String]()

        output += [buildURLDescription(request)]
        output += [buildQueryDescription(request)]
        output += [buildHeadersDescription(request)]
        output += [buildBodyDescription(request)]

        appendLiteral(output.joined(separator: "\n"))
    }

    private func buildURLDescription(_ request: URLRequest) -> String {
        "URL: " + buildURLString(request)
    }

    private func buildURLString(_ request: URLRequest) -> String {
        guard let urlString = request.url else { return "" }
        return urlString.absoluteString
    }

    private func buildQueryDescription(_ request: URLRequest) -> String {
        var output = [String]()

        if let method = request.httpMethod {
            output.append(method)
        }

        if let urlComponents = NSURLComponents(string: buildURLString(request)) {

            if let scheme = urlComponents.scheme {
                output.append(scheme)
            }

            if let host = urlComponents.host {
                output.append(host)
            }

            if let query = urlComponents.query {
                output.append("? " + query)
            }
        }

        return output.joined(separator: " ")
    }

    private func buildHeadersDescription(_ request: URLRequest) -> String {
        var output = ""

        if let headerFields = request.allHTTPHeaderFields, !headerFields.isEmpty {

            output += "HTTP Headers:\n" //TODO: remove form interpolation

            var headers = [String]()
            let sortedHeaderFields = headerFields.sorted { $0.0 < $1.0 }

            for (key, value) in sortedHeaderFields {
                headers.append("  \(key) : \(value)")
            }

            output += headers.joined(separator: "\n")
        }

        return output
    }

    private func buildBodyDescription(_ request: URLRequest) -> String {
        guard
            let httpBody = request.httpBody,
            let string = String(data: httpBody, encoding: .utf8)
        else { return "" }

        return "BODY:\n  \(string)" //TODO: remove body form interpolation
    }
}


public extension String.StringInterpolation {

    mutating func appendInterpolation(response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else { return }

        appendLiteral("StatusCode: \(httpResponse.statusCode)")
    }
}


public extension String.StringInterpolation {

    mutating func appendInterpolation(data: Data) {
        guard
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrinted = String(data: data, encoding: .utf8)
        else { return }

        appendLiteral("JSON:\n\(prettyPrinted)") //TODO: remove form interpolation
    }
}
