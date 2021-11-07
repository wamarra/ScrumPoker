//
//  FindDeveloperRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class FindDeveloperRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = FindDeveloperController(nibName: "FindDeveloperController", bundle: .main)
        let interactor = DeveloperInteractor()
        let presenter = DeveloperPresenter()
        
        view.presenter = presenter
        presenter.findViewController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
