//
//  DeveloperRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 02/11/21.
//

import UIKit

class SaveDeveloperRouter: ModuleWireframe {
    
    weak var viewController: UIViewController?
    
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
    
    func showViewFindDeveloper() {
        let findDeveloperView = FindDeveloperRouter.assembleModule()
        
        findDeveloperView.title = "Pesquisar Desenvolvedor"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        viewController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        viewController?.navigationController?.pushViewController(findDeveloperView, animated: true)
    }
}
