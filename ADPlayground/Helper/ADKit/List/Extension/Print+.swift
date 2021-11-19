//
//  Print+.swift
//  Ra7ty
//
//  Created by Adel Radwan on 05/10/2021.
//  Copyright © 2021 Ra7ty. All rights reserved.
//

import Foundation

public enum LogType: String{ case error, warning, success, action, canceled }

public func log(
    type: LogType, _ items: Any..., filename: String = #file, function : String = #function,
    line: Int = #line, separator: String = " ", terminator: String = "\n"
) {
    
#if DEBUG
    let pretty = "\(URL(fileURLWithPath: filename).lastPathComponent) [#\(line)] \(function) -> "
    let output = items.map { "\($0)" }.joined(separator: separator)
    
    switch type {
    case LogType.error:
        Swift.print("🔞 Error: -> ",pretty+output, terminator: terminator)
    case LogType.warning:
        Swift.print("⚠️ Warning: -> ",pretty+output, terminator: terminator)
    case LogType.success:
        Swift.print("✅ Success: -> ",pretty+output, terminator: terminator)
    case LogType.action:
        Swift.print("🗄 Action: -> ",pretty+output, terminator: terminator)
    case LogType.canceled:
        Swift.print("❌ Cancelled: -> ",pretty+output, terminator: terminator)
    }
    Swift.print("=======================================================================================")
#else
    Swift.print("RELEASE MODE")
#endif
}
