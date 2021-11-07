//
//  SaveSprintRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class SaveSprintRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = SaveSprintController(nibName: "SaveSprintController", bundle: .main)
        let interactor = SprintInteractor()
        let presenter = SprintPresenter()
        
        view.presenter = presenter
        presenter.saveSprintController = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }    
}
