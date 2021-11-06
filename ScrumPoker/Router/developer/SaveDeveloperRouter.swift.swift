//
//  DeveloperRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 02/11/21.
//

import UIKit

protocol SaveDeveloperWireframe {
    static func assembleModule() -> UIViewController
}

class SaveDeveloperRouter: SaveDeveloperWireframe {
    
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
        
        view.title = "Pesquisar"
        view.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [view]
        
        let navigation = UINavigationController(rootViewController: tabBarController)
        navigation.navigationBar.items?[0].title = "Cadastrar Desenvolvedor"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigation.navigationBar.titleTextAttributes = textAttributes
        
        return navigation
    }
    
    func showViewFindDeveloper() {
        let findDeveloperView = FindDeveloperRouter.assembleModule()
        
        findDeveloperView.title = "Pesquisar Desenvolvedor"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        viewController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        viewController?.navigationController?.pushViewController(findDeveloperView, animated: true)
    }
}
