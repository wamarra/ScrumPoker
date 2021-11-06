//
//  FindDeveloperRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

protocol FindDeveloperWireframe {
    static func assembleModule() -> UIViewController
}

class FindDeveloperRouter: FindDeveloperWireframe {
    
    static func assembleModule() -> UIViewController {
        let findDeveloperController = FindDeveloperController(nibName: "FindDeveloperController", bundle: .main)
        let interactor = DeveloperInteractor()
        let presenter = DeveloperPresenter()
        
        findDeveloperController.presenter = presenter
        presenter.findViewController = findDeveloperController
        presenter.interactor = interactor
        interactor.output = presenter
        
        return findDeveloperController
    }
}
