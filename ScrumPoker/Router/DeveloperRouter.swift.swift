//
//  DeveloperRouter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 02/11/21.
//

import UIKit

class DeveloperRouter {
    let view = DeveloperViewController(nibName: "DeveloperViewController", bundle: .main)
    let interractor = DeveloperInteractor()
    let presenter = DeveloperPresenter()
    
    init() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interractor
        interractor.output = presenter
    }
    
    func present(on window: UIWindow) {
        window.rootViewController = view
    }
}
