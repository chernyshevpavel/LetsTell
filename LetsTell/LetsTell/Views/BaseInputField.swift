//
//  BaseInputField.swift
//  LetsTell
//
//  Created by Павел Чернышев on 28.03.2021.
//

import SwiftUI

struct BaseInputField<T: View>: View {
    @Environment(\.colorScheme) var colorScheme
    var input: T
    
    var body: some View {
        input
            .padding(.horizontal, 15.0)
            .frame(height: 40.0)
            .foregroundColor(colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .black))
            .background(
                colorScheme == .dark ? Color(customDarkModeColor: .mediumGray) :
                    Color(customColor: .lightGray)
            )
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(customColor: .borderBlak), lineWidth: 1))
    }
}

struct BaseInputField_Previews: PreviewProvider {
    @State var text = ""
    
    static var previews: some View {
        Group {
            BaseInputField(input: TextField("Password", text: .constant("")))
            BaseInputField(input: TextField("Password", text: .constant("")))
            
            BaseInputField(input: TextField("Password", text: .constant("")))
                .environment(\.colorScheme, .dark)
            BaseInputField(input: TextField("Password", text: .constant("")))
                .environment(\.colorScheme, .dark)
            
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
