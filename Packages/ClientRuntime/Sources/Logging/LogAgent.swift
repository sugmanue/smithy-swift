/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0.
 */

public protocol LogAgent {
    /// name of the struct or class where the logger was instantiated from
    var name: String {get}
    
    /// Get or set the configured log level.
    var level: LogAgentLevel {get set}
    
    /// This method is called when a `LogAgent` must emit a log message.
    ///
    /// - parameters:
    ///     - level: The `LogAgentLevel` the message was logged at.
    ///     - message: The message to log.
    ///     - metadata: The metadata associated to this log message as a dictionary
    ///     - source: The source where the log message originated, for example the logging module.
    ///     - file: The file the log message was emitted from.
    ///     - function: The function the log line was emitted from.
    ///     - line: The line the log message was emitted from.
    func log(level: LogAgentLevel,
             message: String,
             metadata: [String: String]?,
             source: String,
             file: String,
             function: String,
             line: UInt)
}

public enum LogAgentLevel: String, Codable, CaseIterable {
    case trace
    case debug
    case info
    case warn
    case error
    case fatal
}

public extension LogAgent {
    internal static func currentModule(filePath: String = #file) -> String {
        let utf8All = filePath.utf8
        return filePath.utf8.lastIndex(of: UInt8(ascii: "/")).flatMap { lastSlash -> Substring? in
            utf8All[..<lastSlash].lastIndex(of: UInt8(ascii: "/")).map { secondLastSlash -> Substring in
                filePath[utf8All.index(after: secondLastSlash) ..< lastSlash]
            }
        }.map {
            String($0)
        } ?? "n/a"
    }
    
    /// Log a message passing with the `.info` log level.
    func info(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .info,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
    
    /// Log a message passing with the `LogLevel.warn` log level.
    func warn(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .warn,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
    
    /// Log a message passing with the `.debug` log level.
    func debug(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .debug,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
    
    /// Log a message passing with the `.error` log level.
    func error(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .error,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
    
    /// Log a message passing with the `.trace` log level.
    func trace(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .trace,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
    
    /// Log a message passing with the `.fatal` log level.
    func fatal(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(level: .fatal,
                 message: message,
                 metadata: nil,
                 source: Self.currentModule(),
                 file: file,
                 function: function,
                 line: line)
    }
}
