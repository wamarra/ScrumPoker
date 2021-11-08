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

protocol ModuleWireframe {
    static func assembleModule() -> UIViewController
}

class AppRouter: RootWireframe {
    
    let tabBarController = UITabBarController()
    
    let sprintRouter = ListSprintRouter.assembleModule()
    let developerRouter = SaveDeveloperRouter.assembleModule()
    let storyRouter = ListStoryBySprintRouter.assembleModule()
    let voteRouter = VoteRouter.assembleModule()
    
    func present(on window: UIWindow) {
        window.makeKeyAndVisible()
        
        sprintRouter.title = "Sprint"
        sprintRouter.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")
        
        storyRouter.title = "Estória"
        storyRouter.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
        voteRouter.title = "Votação"
        voteRouter.tabBarItem.image = UIImage(systemName: "checkmark.bubble")
        
        developerRouter.title = "Desenvolvedor"
        developerRouter.tabBarItem.image = UIImage(systemName: "person")
        
        tabBarController.viewControllers = [sprintRouter, storyRouter, voteRouter, developerRouter]
        
        window.rootViewController = tabBarController
    }
}
