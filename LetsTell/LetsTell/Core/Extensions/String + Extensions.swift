//
//  String + Extensions.swift
//  LetsTell
//
//  Created by Павел Чернышев on 10.05.2021.
//

import Foundation

extension String {
    func localized (bundle: Bundle = .main, tableName: String? = nil) -> String {
        NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}
