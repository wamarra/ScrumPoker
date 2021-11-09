//
//  StoryRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit

class ListStoryBySprintRouter: ModuleWireframe {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = ListStoryBySprintController(nibName: "ListStoryBySprintController", bundle: .main)
        let interactor = StoryInteractor()
        let presenter = StoryPresenter()
        let router = ListStoryBySprintRouter()
        
        view.presenter = presenter
        presenter.listController = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        interactor.output = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    func showViewAddStory() {
        let saveStoryView = SaveStoryRouter.assembleModule()
        
        saveStoryView.title = "Cadastrar Estória"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        viewController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        viewController?.navigationController?.pushViewController(saveStoryView, animated: true)
    }
}
