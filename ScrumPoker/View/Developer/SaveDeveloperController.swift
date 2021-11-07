//
//  SaveDeveloperViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol SaveDeveloperToPresenter: AnyObject {
    var developerObserver: Observable<Developer> { get }
    func setLoading(_ loading: Bool)
}

class SaveDeveloperController: UIViewController, UITabBarControllerDelegate {
    
    var developerBehavior = BehaviorRelay<Developer?>(value: nil)
    var presenter: DeveloperPresenterToView!
    let disposeBag = DisposeBag()
    
    private var developer: Developer?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func onSaveDeveloper(_ sender: UIButton) {
        guard let name = nameField.text, let email = emailField.text else { return }
        developerBehavior.accept(Developer(nome: name, email: email))
    }
    
    @IBAction func onFindDeveloper(_ sender: UIBarButtonItem) {
        presenter.showViewFindDeveloper()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            presenter.showViewFindDeveloper()
        }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        bind()
        self.tabBarController?.delegate = self
    }
    
    private func bind() {
        presenter.savedDeveloper.bind { [weak self] developer in
            self?.developer = developer
            self?.showToast(message: "Desenvolvedor salvo com sucesso!")
        }
        .disposed(by: disposeBag)
    }
}

extension SaveDeveloperController: SaveDeveloperToPresenter {
    var developerObserver: Observable<Developer> {
        return developerBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

extension UIViewController {
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 130, y: self.view.frame.size.height-100, width: 250, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = .systemFont(ofSize: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
