//
//  ProfileView.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.03.2021.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authController: AuthViewController
    
    @ObservedObject var profileViewController: ProfileViewController
    
    @State var showingImagePicker = false
    @State var image: Image?
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 20, content: {
                Text(profileViewController.userName)
                Text(profileViewController.userEmail)
            }).foregroundColor(
            colorScheme == .dark ? Color(customDarkModeColor: .whiteGray) : Color(customColor: .black)
            ).padding(.vertical, 30)
            
            if image == nil {
                Image(systemName: "person.fill")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom)
            } else {
                image?.resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom)
            }
            
            Button("Изменить фото") {
                self.showingImagePicker.toggle() 
            }
                .padding(.bottom, 20)
        
            Button("Удалить фото") {
                print("Button tapped!")
                image = nil
            }.foregroundColor(.red)
            .padding(.bottom)
            
            BaseButton(action: {
                self.profileViewController.logout()
            }, text: Text("Logout"))
        }.sheet(isPresented: $showingImagePicker, content: {
            ImagePicker.shared.view
        })
        .onReceive(ImagePicker.shared.$image) { image in self.image = image }
        .padding(.horizontal, 30)
        .onAppear {
            profileViewController.load()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone 11", "iPhone Xs", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
                ProfileView(profileViewController: ProfileViewController()).environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                
                ProfileView(profileViewController: ProfileViewController()).environment(\.colorScheme, .light)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
            }
        }.environmentObject(UserAuthManager())
    }
}
