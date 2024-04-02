//
//  Logger.swift
//  
//
//  Created by Konrad Groschang on 01/02/2023.
//

import Foundation

public struct Logger {

    public enum Level: Comparable {
        case verbose
        case info
        case debug
        case warning
        case error

        var infoIcon: String {
            switch self {
            case .verbose: return ""
            case .info: return " "
            case .debug: return "🔎"
            case .warning: return "⚠️"
            case .error: return "❌"
            }
        }
    }

    static var level = Level.info

    public static func log(_ items: Any..., separator: String = " ", terminator: String = "\n", onLevel level: Level = .debug, file: String = #file, function: String = #function, line: Int = #line) {
        if Self.level <= level {
#if DEBUG
            printLog(items, separator: separator, terminator: terminator, onLevel: level, file: file, function: function, line: line)
#else

#endif
        }
    }

    static private func printLog(_ items: Any..., separator: String = " ", terminator: String = "\n", onLevel level: Level = .verbose, file: String, function: String, line: Int) {
        print(level.infoIcon, terminator: " ")
        print("file: " + (file.components(separatedBy: "/").last ?? ""), terminator: " ")
        print("line: #\(line)", terminator: " ")
        print("function: \(function)", terminator: "\n")
        print("\tmessage:", terminator: " ")
        print(items, separator: separator, terminator: terminator)
    }
}

extension Logger {

    public static func verbose(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator, onLevel: .verbose)
    }

    public static func info(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator, onLevel: .info)
    }

    public static func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator, onLevel: .debug)
    }

    public static func warning(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator, onLevel: .warning)
    }

    public static func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator, onLevel: .error)
    }
}
