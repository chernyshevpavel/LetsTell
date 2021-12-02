//
//  ProfileViewController.swift
//  LetsTell
//
//  Created by Павел Чернышев on 27.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfileDisplayLogic: class {
    func displayLogout(viewModel: Profile.Logout.ViewModel)
    func displayOwner(viewModel: Profile.User.ViewModel)
}

class ProfileViewController: ProfileDisplayLogic, ObservableObject {
    
    var interactor: ProfileBusinessLogic?
    var authController: AuthViewController?

    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var isLoaded: Bool = false
    
    public func setup(container: ObjectsGetter) {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        
        self.authController = container.getObject()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func load() {
        if !isLoaded {
            interactor?.loadOwner(request: Profile.User.Request(load: true))
            isLoaded = true
        }
    }
    
    func displayOwner(viewModel: Profile.User.ViewModel) {
        self.userName = viewModel.name
        self.userEmail = viewModel.email
    }
    
    func logout() {
        let request = Profile.Logout.Request(logout: true)
        interactor?.logout(request: request)
    }
    
    func displayLogout(viewModel: Profile.Logout.ViewModel) {
        if viewModel.logout {
            authController?.logout()
            self.userEmail = ""
            self.userName = ""
            self.isLoaded = false
        }
    }
}
