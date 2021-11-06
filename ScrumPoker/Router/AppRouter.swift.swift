//
//  AppRouter.swift.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

protocol RootWireframe {
    func present(on window: UIWindow)
}

class AppRouter: RootWireframe {
    
    func present(on window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = SaveDeveloperRouter.assembleModule()
    }
}
