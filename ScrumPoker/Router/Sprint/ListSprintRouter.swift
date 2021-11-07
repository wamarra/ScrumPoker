//
//  ListSprintRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class ListSprintRouter: ModuleWireframe {
    
    weak var viewController: UIViewController?
        
    static func assembleModule() -> UIViewController {
        let view = ListSprintController(nibName: "ListSprintController", bundle: .main)
        let interactor = SprintInteractor()
        let presenter = SprintPresenter()
        let router = ListSprintRouter()
        
        view.presenter = presenter
        presenter.listSprintController = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        interactor.output = presenter
        
        return view
    }
    
    func showViewAddSprint() {
        let saveSprintView = SaveSprintRouter.assembleModule()
        
        saveSprintView.title = "Cadastrar Sprint"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        viewController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        viewController?.navigationController?.pushViewController(saveSprintView, animated: true)
    }
}
