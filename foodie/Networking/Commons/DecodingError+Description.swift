//
//  DecodingError+Description.swift
//  foodie
//
//  Created by Konrad Groschang on 31/08/2023.
//

import Foundation

extension DecodingError {

    public var verbose: String {
        var description: String

        switch self {
        case .typeMismatch(let type, let value):
            description = makeDescription(type: type, context: value)
        case .valueNotFound(let type, let context):
            description = makeDescription(type: type, context: context)
        case .keyNotFound(let key, let context):
            description = makeDescription(key: key, context: context)
        case .dataCorrupted(let context):
            description = makeDescription(context: context)
        default:
            description = makeDescription()
        }

        return description
    }
}

private extension DecodingError {

    func makeDescription() -> String {
        describe()
    }

    @DecodingErrorDescription
    func makeDescription(context: DecodingError.Context) -> String {
        describe()
        describe(context)
    }

    @DecodingErrorDescription
    func makeDescription(
        type: Any.Type,
        context: DecodingError.Context
    ) -> String {
        describe()
        describe(type)
        describe(context)
    }

    @DecodingErrorDescription
    func makeDescription(
        key: CodingKey,
        context: DecodingError.Context
    ) -> String {
        describe()
        describe(key)
        describe(context)
    }

    private func describe() -> String {
        "Description: \(localizedDescription)"
    }

    @DecodingErrorDescription
    private func describe(_ context: DecodingError.Context) -> String {
        "Context:"

        if context.codingPath.isNotEmpty {
            String.tab + "codingPath: \(context.codingPath)"
        }

        String.tab + "description: \(context.debugDescription)"

        if let underlyingError = context.underlyingError {
            String.tab +
            "underlyingError: \(underlyingError.localizedDescription)"
        }
    }

    private func describe(_ key: CodingKey) -> String {
        "Key: \(key)"
    }

    private func describe(_ type: Any.Type) -> String {
        "Type: \(type)"
    }
}


@resultBuilder
fileprivate struct DecodingErrorDescription {

    static func buildBlock(_ parts: String...) -> String {
        parts
            .filter { $0.isNotEmpty }
            .joined(separator: "\n")
    }

    static func buildExpression(_ expression: String) -> String {
        expression
    }

    static func buildExpression(_ expression: [String]) -> [String] {
        expression
    }

    static func buildOptional(_ component: String?) -> String {
        component ?? ""
    }

    static func buildEither(first components: String) -> String {
        components
    }

    static func buildEither(second components: String) -> String {
        components
    }
}
