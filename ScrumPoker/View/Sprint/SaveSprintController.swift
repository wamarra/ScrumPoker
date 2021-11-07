//
//  SaveSprintViewController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol SaveSprintToPresenter: AnyObject {
    var sprintObserver: Observable<Sprint> { get }
    func setLoading(_ loading: Bool)
}

class SaveSprintController: UIViewController {
    
    var sprintBehavior = BehaviorRelay<Sprint?>(value: nil)
    var presenter: SprintPresenterToView!
    let disposeBag = DisposeBag()
    
    private var sprint: Sprint?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var linkField: UITextField!
    
    @IBAction func onSaveSprint(_ sender: UIButton) {
        guard let name = nameField.text, let link = linkField.text else { return }
        sprintBehavior.accept(Sprint(nome: name, link: link))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SaveSprintController: SaveSprintToPresenter {
    var sprintObserver: Observable<Sprint> {
        return sprintBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}
