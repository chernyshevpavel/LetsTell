//
//  ContainerConfiguratorProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 10.05.2021.
//

import Foundation
import Swinject

protocol ContainerConfiguratorProtocol {
    func configure(_ container: Container)
}
