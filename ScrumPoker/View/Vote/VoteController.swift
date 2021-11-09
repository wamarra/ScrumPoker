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
    
    private var vote: Vote?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var storyField: UITextField!
    
    @IBOutlet weak var developerField: UITextField!
    
    @IBOutlet weak var pointsField: UITextField!
    
    @IBAction func onRegisterVote(_ sender: UIButton) {
        guard let story = storyField.text,
                let developer = developerField.text,
                let points = pointsField.text else { return }
        voteBehavior.accept(Vote(idEstoria: Int(story), idDesenvolvedor: Int(developer), pontos: Int(points)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        presenter.viewDidLoad()
        bind()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Votação"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func bind() {
        presenter.registeredVote.bind { [weak self] vote in
            self?.vote = vote
            self?.showToast(message: "Voto computado com sucesso!")
        }
        .disposed(by: disposeBag)
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
