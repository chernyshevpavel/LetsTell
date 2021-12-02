//
//  Font + Extension.swift
//  LetsTell
//
//  Created by Павел Чернышев on 19.04.2021.
//

import UIKit

extension UIFont {
    static func printAll() {
        familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }
}
