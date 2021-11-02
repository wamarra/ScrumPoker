//
//  DeveloperViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 02/11/21.
//

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

protocol DeveloperSaveViewToPresenter: AnyObject {
    var developerObserver: Observable<Developer> { get }
    func setLoading(_ loading: Bool)
}

class DeveloperSaveViewController: UIViewController {
    
    var developerBehavior = BehaviorRelay<Developer?>(value: nil)
    var presenter: DeveloperPresenterToView!
    let disposeBag = DisposeBag()
    
    private var developer: Developer?
    
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    @IBOutlet weak var nam: UITextField!
    
    @IBOutlet weak var ema: UITextField!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        bind()
    }
    
    private func bind() {
        presenter.savedDeveloper.bind { [weak self] developer in
            self?.developer = developer
        }
        .disposed(by: disposeBag)
    }
}

extension DeveloperSaveViewController: DeveloperSaveViewToPresenter {
    var developerObserver: Observable<Developer> {
        return developerBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.ind.startAnimating()
        } else {
            self.ind.stopAnimating()
        }
    }
}
