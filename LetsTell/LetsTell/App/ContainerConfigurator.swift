//
//  ContainerConfigurator.swift
//  LetsTell
//
//  Created by Павел Чернышев on 10.05.2021.
//

import Foundation
import Swinject

class ContainerConfigurator: ContainerConfiguratorProtocol {
    public func configure(_ container: Container) {
        loggerServicesRegister(container)
        
        dbConfiguratorRegister(container)
        dbStoragesRegister(container)
        
        tokenWorkersRegister(container)
        
        authManagerRegister(container)
        requestFactoryRegister(container)
    }
    
    private func loggerServicesRegister(_ container: Container) {
        container.register(ErrorLogger.self) { _ in
            CrashlyticsErrorLogger(chainLogger: PrintLogger())
        }
    }
    
    private func dbConfiguratorRegister(_ container: Container) {
        container.register(DBConfiguratorProtocol.self) { _ in
            RealmConfigurator()
        }
    }
    
    private func dbStoragesRegister(_ container: Container) {
        container.register(TokenStorage.self) { _ in
            RealmTokenStorage()
        }
        
        container.register(OwnerStorage.self) { _ in
            RealmOwnerStorage()
        }
        
        container.register(ApplyedFiltersStorage.self) { _ in
            let storage = RealmApplyedFiltersStorage()
            storage.logger = container.resolve(ErrorLogger.self)
            return storage
        }
    }
    
    private func tokenWorkersRegister(_ container: Container) {
        container.register(TockenCheckerProtocol.self) { _ in
            TockenChecker(store: self.getRegistredObject(container))
        }
        
        container.register(TokenRefresherProtocol.self) { _ in
            TokenRefresher(store: self.getRegistredObject(container),
                           requestFactory: self.getRegistredObject(container),
                           errorLogger: self.getRegistredObject(container),
                           userStorage: self.getRegistredObject(container))
        }
    }
    
    private func authManagerRegister(_ container: Container) {
        container.register(UserAuth.self) { _ in
            UserAuthManager()
        }
    }
    
    private func requestFactoryRegister(_ container: Container) {
        container.register(RequestFactory.self) { _ in
            RequestFactory(baseUrl: apiUrl)
        }
    }
    
    private func getRegistredObject<T>(_ container: Container) -> T {
        guard let object = container.resolve(T.self) else {
            fatalError("Couldn't get \(T.self)")
        }
        return object
    }
}
