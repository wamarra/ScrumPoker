//
//  StoryRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class ListStoryBySprintRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = ListStoryBySprintController(nibName: "ListStoryBySprintController", bundle: .main)
        let interactor = StoryInteractor()
        let presenter = StoryPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
