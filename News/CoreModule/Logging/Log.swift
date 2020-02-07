//
//  Log.swift
//  2T-CoreModule
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2019 Trung Vu. All rights reserved.
//

import Foundation
import XCGLogger

public class Log {
    
    static fileprivate let logger: XCGLogger = {
        
        let logger = XCGLogger()
        
        #if DEBUG
        let logLevel = XCGLogger.Level.verbose
        #else
        let logLevel = XCGLogger.Level.severe
        #endif
        
        logger.setup(
            level: logLevel,
            showLogIdentifier: false,
            showFunctionName: false,
            showThreadName: false,
            showLevel: true,
            showFileNames: true,
            showLineNumbers: true,
            showDate: true,
            writeToFile: nil,
            fileLevel: .none
        )
        
        return logger
        
    } ()
    
    class func logObject(_ logLevel: XCGLogger.Level, object: Any?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logger.logln(
            logLevel,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: {
                if let logObject = object {
                    if logObject is CustomDebugStringConvertible {
                        // debugDescription from CustomDebugStringConvertible
                        return (logObject as! CustomDebugStringConvertible).debugDescription
                    } else if logObject is CustomStringConvertible {
                        return (logObject as! CustomStringConvertible).description
                    } else {
                        return "This object not string convertible."
                    }
                } else {
                    // debugDescription from optional
                    return object.debugDescription
                }
        }
        )
    }
    
    // debug
    public class func debug(_ object: Any?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logObject(
            .debug,
            object: object,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    /**
     Log.debug { return "\(1 + 2)" }
     */
    public class func debug(_ functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        self.logger.logln(
            .debug,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: closure
        )
        
    }
    
    // info
    public class func info(_ object: AnyObject, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logObject(
            .info,
            object: object,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    /**
     Log.debug { return "\(1 + 2)" }
     */
    public class func info(_ functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        self.logger.logln(
            .info,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: closure
        )
        
    }
    
    // verbose
    public class func verbose(_ object: AnyObject, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logObject(
            .verbose,
            object: object,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    /**
     Log.debug { return "\(1 + 2)" }
     */
    public class func verbose(_ functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        self.logger.logln(
            .verbose,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: closure
        )
    }
    
    // warning
    public class func warning(_ object: AnyObject, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logObject(
            .warning,
            object: object,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    /**
     Log.debug { return "\(1 + 2)" }
     */
    public class func warning(_ functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        self.logger.logln(
            .warning,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: closure
        )
        
    }
    
    // error
    public class func error(_ object: AnyObject, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.logObject(
            .error,
            object: object,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber
        )
    }
    
    /**
     Log.debug { return "\(1 + 2)" }
     */
    public class func error(_ functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        self.logger.logln(
            .error,
            functionName: functionName,
            fileName: fileName,
            lineNumber: lineNumber,
            closure: closure
        )
        
    }
    
}

