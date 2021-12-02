//
//  ErrorParserState.swift
//  LetsTell
//
//  Created by Павел Чернышев on 15.03.2021.
//

import Foundation
import Alamofire

class ErrorParserState<T: Decodable & Error>: AbstractErrorParser {
    var parsedError: T?
    func parse(_ result: Error) -> Error {
        result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        guard let data = data, error == nil else {
            return error
        }
        do {
            let parsedError = try JSONDecoder().decode(T.self, from: data)
            self.parsedError = parsedError
            return parsedError
        } catch {
            return nil
        }
    }
}
