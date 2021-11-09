//
//  SaveStoryRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 08/11/21.
//

import UIKit

class SaveStoryRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = SaveStoryController(nibName: "SaveStoryController", bundle: .main)
        let interactor = StoryInteractor()
        let presenter = StoryPresenter()
        
        view.presenter = presenter
        presenter.saveController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}

