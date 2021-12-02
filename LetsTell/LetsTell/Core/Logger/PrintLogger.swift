//
//  PrintLogger.swift
//  LetsTell
//
//  Created by Павел Чернышев on 10.05.2021.
//

import Foundation

class PrintLogger: ErrorLogger {
    func log(_ nsError: NSError) {
        print(nsError)
    }
    
    func log(_ error: Error) {
        print(error.localizedDescription)
    }
}
