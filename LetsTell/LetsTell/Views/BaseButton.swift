//
//  BaseButton.swift
//  LetsTell
//
//  Created by Павел Чернышев on 28.03.2021.
//

import SwiftUI

struct BaseButton: View {
    @State var action: () -> Void
    var text: Text
    
    var body: some View {
        Button(action: action, label: {
            text
                .fontWeight(.medium)
                .textCase(.uppercase)
                .frame(idealWidth: .infinity, maxWidth: .infinity, minHeight: 45.0)
        })
        .overlay(RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(.clear), lineWidth: 0))
        .foregroundColor(Color(customColor: .black))
        .background(Color(customColor: .yellow))
        .cornerRadius(14)
    }
}

struct BaseButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BaseButton(action: {}, text: Text("Sign in"))
                .disabled(true)
            
            BaseButton(action: {}, text: Text("Sign in"))
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
