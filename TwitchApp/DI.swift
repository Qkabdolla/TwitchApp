//
//  DI.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import Swinject
import SwinjectAutoregistration

func registerDependencies(in container: Container) {
    container.autoregister(NetworkService.self, initializer: NetworkService.init)
    container.autoregister(DBService.self, initializer: DBService.init)
    container.autoregister(DataService.self, initializer: DataService.init)
    container.autoregister(MainViewModel.self, initializer: MainViewModel.init)
}
