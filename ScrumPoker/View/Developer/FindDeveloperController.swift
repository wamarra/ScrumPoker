//
//  DeveloperFindViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 03/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol FindDeveloperToPresenter: AnyObject {
    var developerObserver: Observable<Developer> { get }
    func setLoading(_ loading: Bool)
}

class FindDeveloperController: UIViewController {
    
    var developerBehavior = BehaviorRelay<Developer?>(value: nil)
    var presenter: DeveloperPresenterToView!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBAction func onFindDeveloper(_ sender: UIButton) {
        guard let id = idField.text, let email = emailField.text else { return }
        developerBehavior.accept(Developer(id: Int(id), email: email))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.findViewDidLoad()
        bind()
    }
    
    private func bind() {
        presenter.developerRecoveredById.bind { [weak self] developer in
            self?.name?.text = developer.nome
        }
        .disposed(by: disposeBag)
  
        presenter.developerRecoveredByEmail.bind { [weak self] developer in
            self?.name?.text = developer.nome
        }
        .disposed(by: disposeBag)
    }
}

extension FindDeveloperController: FindDeveloperToPresenter {
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
