//
//  ErrorLogger.swift
//  LetsTell
//
//  Created by Павел Чернышев on 04.04.2021.
//

import Foundation

protocol ErrorLogger {
    func log(_ nsError: NSError)
    func log(_ error: Error)
}
