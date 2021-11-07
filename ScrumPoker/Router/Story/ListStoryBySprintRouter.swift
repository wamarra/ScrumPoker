//
//  StoryRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class ListStoryBySprintRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = SaveDeveloperController(nibName: "SaveDeveloperController", bundle: .main)
        let interactor = DeveloperInteractor()
        let presenter = DeveloperPresenter()
        let router = SaveDeveloperRouter()
        
        view.presenter = presenter
        presenter.saveViewController = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        interactor.output = presenter
        
        return view
    }
}
