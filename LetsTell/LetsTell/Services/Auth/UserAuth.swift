//
//  UserAuth.swift
//  LetsTell
//
//  Created by Павел Чернышев on 27.03.2021.
//

import Foundation

protocol UserAuth {
    var isLoggedin: Bool { get set }
}

extension UserAuth where Self: ObservableObject {
    
}

class UserAuthManager: UserAuth, ObservableObject {
    var userAuth: UserAuth?
    
    func set(userAuth: UserAuth) {
        self.userAuth = userAuth
    }
    
    @Published var isLoggedin: Bool = false
}
