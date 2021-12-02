//
//  AppController.swift
//  LetsTell
//
//  Created by Павел Чернышев on 10.05.2021.
//

import Foundation
import Swinject
import Firebase

class ApplicationManager: ObjectsGetter, ObservableObject {
    
    let container = Container()
    let containerConfigurator: ContainerConfiguratorProtocol = ContainerConfigurator()
    
    init(_ configure: Bool = true) {
        if configure {
            FirebaseApp.configure()
            configurateContainer()
            configurateDB()
        }
    }
    
    public func getObject<T>() -> T {
        guard let result = container.resolve(T.self) else {
            if T.self == ErrorLogger.self {
                fatalError("Couldn't get Logger".localized())
            }
            let logger: ErrorLogger = self.getObject()
            logger.log(NSError(domain: "AppController",
                               code: NSError.ErrorCodes.containerGetObjectError.rawValue,
                               userInfo: ["type": T.self]))
            fatalError("Couldn't get object \(T.self)")
        }
        return result
    }
    
    private func configurateContainer() {
        containerConfigurator.configure(container)
    }
        
    private func configurateDB() {
        let dbConfigurator: DBConfiguratorProtocol = self.getObject()
        dbConfigurator.configurate()
    }
}
