//
//  ContentView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 11.03.2021.
//

import UIKit
import SwiftUI

struct AuthView: View, KeyboardReadable {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var email = ""
    @State var password = ""
    @ObservedObject var authViewController: AuthViewController
    @State private var isKeyboardVisible = false
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                if !isKeyboardVisible {
                    Image("logo")
                    
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 95, maxHeight: 95)
                } else {
                    Text("letstell.")
                        .font(.custom("SFPro-Regular", size: 25))
                        .foregroundColor(Color(customColor: .yellow))
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 50, maxHeight: 50)
                }
                
                VStack(spacing: 12) {
                    Text("The story begins")
                        .font(.custom("Merriweather-Regular", size: 24, relativeTo: .caption2))
                        .fontWeight(.light)
                    Text("app_describer_greeting")
                        .font(.custom("Merriweather-Regular", size: 13, relativeTo: .body))
                }
                .foregroundColor( colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .secondGray))
                
                Spacer()
                    .frame(minHeight: 10, idealHeight: 40, maxHeight: 40)
                
                VStack(spacing: 11) {
                    Group {
                        BaseInputField(input: TextField("Email", text: $email))
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        BaseInputField(input: SecureField("Password", text: $password)
                                        .textContentType(.password))
                    }
                    
                    ZStack {
                        BaseButton(action: {
                            self.authViewController.login(
                                email: self.email,
                                password: self.password)
                            self.authViewController.disabledSignin = true
                        }, text: Text("Sign in"))
                        .alert(isPresented: .constant(!self.authViewController.errorMessage.isEmpty), content: {
                            Alert(
                                title: Text("Error")
                                    .foregroundColor(Color.red),
                                message: Text("\(self.authViewController.errorMessage)")
                                    .foregroundColor(.red),
                                dismissButton: .default(Text("Ok"), action: {
                                    self.authViewController.errorMessage = ""
                                })
                            )
                        })
                        .opacity(authViewController.disabledSignin ? 0.5 : 1)
                        .disabled(authViewController.disabledSignin)
                        
                        if authViewController.disabledSignin {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(customColor: .lightGray)))
                        } else {
                            EmptyView()
                        }
                    }
                }
                .padding(.horizontal, 30.0)
                .font(.custom("SFPro-Regular", size: 17))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(
            colorScheme == .dark ? Color(customDarkModeColor: .background).edgesIgnoringSafeArea(.all) :
                Color(customColor: .generalText).edgesIgnoringSafeArea(.all)
        ).onReceive(keyboardPublisher) { newIsKeyboardVisible in
            print("Is keyboard visible? ", newIsKeyboardVisible)
            isKeyboardVisible = newIsKeyboardVisible
        }.animation(.spring())
    }
    
}

struct ContentViewPreviews2: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            ForEach(["iPhone 11", "iPhone Xs", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
                AuthView(authViewController: AuthViewController()).environment(\.colorScheme, .dark)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
                
                AuthView(authViewController: AuthViewController()).environment(\.colorScheme, .light)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
