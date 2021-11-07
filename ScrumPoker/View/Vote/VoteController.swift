//
//  VoteController.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxRelay

protocol VoteToPresenter: AnyObject {
    var voteObserver: Observable<Vote> { get }
    func setLoading(_ loading: Bool)
}

class VoteController: UIViewController {
    
    var voteBehavior = BehaviorRelay<Vote?>(value: nil)
    var presenter: VotePresenterToView!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var storyField: UITextField!
    
    @IBOutlet weak var developerField: UITextField!
    
    @IBOutlet weak var pointsField: UITextField!
    
    @IBAction func onRegisterVote(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension VoteController: VoteToPresenter {
    var voteObserver: Observable<Vote> {
        return voteBehavior.unwrap().asObservable()
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}
