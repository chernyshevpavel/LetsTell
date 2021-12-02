//
//  CrashlyticsErrorLogger.swift
//  LetsTell
//
//  Created by Павел Чернышев on 16.05.2021.
//

import Foundation
import Firebase

class CrashlyticsErrorLogger: ErrorLogger {
    var chainLogger: ErrorLogger?
    
    init(chainLogger: ErrorLogger? = nil) {
        self.chainLogger = chainLogger
    }
    
    func log(_ nsError: NSError) {
        Crashlytics.crashlytics().record(error: nsError)
        chainLogger?.log(nsError)
    }
    
    func log(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
        chainLogger?.log(error)
    }
}
