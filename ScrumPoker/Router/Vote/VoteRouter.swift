//
//  VoteRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class VoteRouter: ModuleWireframe {
    
    static func assembleModule() -> UIViewController {
        let view = VoteController(nibName: "VoteController", bundle: .main)
        let interactor = VoteInteractor()
        let presenter = VotePresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}
