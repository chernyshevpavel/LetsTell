//
//  UIColor + Extension.swift
//  LetsTell
//
//  Created by Павел Чернышев on 23.03.2021.
//

import UIKit
import SwiftUI

enum CustomColors {
    case generalBackground
    case additionBackground
    case buttons
    case borderBlak
    case yellow
    case generalText
    case lightGray
    case gray5
    case secondGray
    case additionalText
    case black
    case tabbarWhite
    case navBarModalStackDark
}

enum CustomDarkModeColors {
    case background
    case mediumGray
    case cellGray
    case whiteGray
    case textSecondGray
    case black
    case subtitle
}

extension Color {
    init(customColor: CustomColors) {
        switch customColor {
        case .generalBackground:
            self.init(#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)) // 2D2D2D
        case .additionBackground:
            self.init(#colorLiteral(red: 0.2431372549, green: 0.2392156863, blue: 0.2392156863, alpha: 1)) // 3E3D3D
        case .navBarModalStackDark:
            self.init(#colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1294117647, alpha: 1)) // 202021
        case .buttons:
            self.init(#colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)) // 313131
        case .borderBlak:
            self.init(#colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)) // 515151
        case .yellow:
            self.init(#colorLiteral(red: 0.9607843137, green: 0.8039215686, blue: 0.4745098039, alpha: 1))
        case .generalText:
            self.init(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)) // F2F2F2
        case .lightGray:
            self.init(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)) // EBEBEB
        case .gray5:
            self.init(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)) // E0E0E0
        case .secondGray:
            self.init(#colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)) // 4F4F4F
        case .additionalText:
            self.init(#colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)) // 828282
        case .black:
            self.init(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)) // 333333
        case .tabbarWhite:
            self.init(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)) // F9F9F9
        }
    }
    
    init(customDarkModeColor: CustomDarkModeColors) {
        switch customDarkModeColor {
        case .background:
            self.init(#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)) // 2D2D2D
        case .mediumGray:
            self.init(#colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)) // 515151
        case .cellGray:
            self.init(#colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)) // #3D3D3D
        case .whiteGray:
            self.init(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)) // F2F2F2
        case .textSecondGray:
            self.init(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)) // CBD2DB
        case .black:
            self.init(#colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)) // 313131
        case .subtitle:
            self.init(#colorLiteral(red: 0.7960784314, green: 0.8235294118, blue: 0.8588235294, alpha: 1)) // #CBD2DB
        }
    }
}
