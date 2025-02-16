//
//  Logger.swift
//  ToDoTasks
//
//  Created by Максим on 18.11.2024.

import Foundation

enum Log {
    enum LogLevel {
        case info
        case warning
        case error

        fileprivate var prefix: String {
            switch self {
            case .info:    return "INFO ✳️"
            case .warning: return "WARN ⚠️"
            case .error:   return "ALERT ❌"
            }
        }
    }

    struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }

    // Убираем логирование в RELEASE конфигурации
    #if !RELEASE
    static func info(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        handleLog(level: .info, str: str, shouldLogContext: shouldLogContext, context: context)
    }

    static func warning(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        handleLog(level: .warning, str: str, shouldLogContext: shouldLogContext, context: context)
    }

    static func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        handleLog(level: .error, str: str, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]", str]
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += " ➜ \(context.description)"
        }

        #if DEBUG
        print(fullString)
        #endif
    }
    #else
    // В режиме RELEASE просто пустой метод, который не делает ничего
    static func info(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {}
    static func warning(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {}
    static func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {}
    #endif
}

