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

class SaveDeveloperController: UIViewController {
    
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
    
    @objc func onFindDeveloper(_ sender: UIBarButtonItem) {
        presenter.showViewFindDeveloper()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupNavigationItem()
        bind()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Cadastrar Desenvolvedor"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onFindDeveloper(_:)))
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
