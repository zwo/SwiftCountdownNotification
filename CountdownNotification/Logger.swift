//
//  Logger.swift
//  CountdownNotification
//
//  Created by 周维鸥 on 2024/10/12.
//

import Foundation

class Logger {
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        Swift.print(items.map { "\($0)" }.joined(separator: separator), terminator: terminator)
        #endif
    }
    
    static func logError(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(items.map { "\($0)" }.joined(separator: separator), terminator: terminator)
    }
}
