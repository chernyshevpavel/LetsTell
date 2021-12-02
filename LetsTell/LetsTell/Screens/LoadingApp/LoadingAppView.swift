//
//  LoadingAppView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 29.03.2021.
//

import UIKit
import SwiftUI

struct LoadingAppView: View, KeyboardReadable {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var controller: LoadingAppViewController
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Image("logo")
                
                Spacer()
                    .frame(minHeight: 10, idealHeight: 95, maxHeight: 95)
                
                VStack(spacing: 12) {
                    Text("The story begins")
                        .font(.custom("Merriweather", size: 24, relativeTo: .title))
                        .fontWeight(.light)
                    Text("app_describer_greeting")
                        .font(.custom("Merriweather", size: 13, relativeTo: .body))
                }
                .foregroundColor( colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .secondGray))
                
                Spacer()
                    .frame(minHeight: 10, idealHeight: 40, maxHeight: 40)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: colorScheme == .dark ? Color( customColor: .lightGray) : Color( customColor: .black)))
                    .frame(width: 0, height: 0, alignment: .center)
                
                VStack(spacing: 11, content: {
                    // place for email input
                    Spacer()
                        .frame(minHeight: 40, idealHeight: 40, maxHeight: 40)
                    // place for password input
                    Spacer()
                        .frame(minHeight: 40, idealHeight: 40, maxHeight: 40)
                    // place for sign in btn
                    Spacer()
                        .frame(minHeight: 45, idealHeight: 45, maxHeight: 45)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(
            colorScheme == .dark ? Color(customDarkModeColor: .background).edgesIgnoringSafeArea(.all) :
                Color(customColor: .generalText).edgesIgnoringSafeArea(.all)
        ).animation(.spring())
    }
}

struct LoadingAppViewPreviews: PreviewProvider {
    
    static var controller = LoadingAppViewController()
    
    static var previews: some View {
        controller.authController = AuthViewController()
        return Group {
            ForEach(["iPhone 11", "iPhone Xs", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
                
                LoadingAppView(controller: controller).environment(\.colorScheme, .dark)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
                
                LoadingAppView(controller: controller).environment(\.colorScheme, .light)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
