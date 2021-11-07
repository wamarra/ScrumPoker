//
//  VotePresenter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

protocol VotePresenterToView: AnyObject {
    var registeredVote: Observable<Vote> { get }
    func viewDidLoad()
}

class VotePresenter {
    weak var view: VoteToPresenter?
    
    var interactor: VoteInteractorInput?
    var voteBehavior = BehaviorRelay<Vote?>(value: nil)
    let disposeBag = DisposeBag()
    
    func bind() {
        if let view = self.view {
            view.voteObserver.bind { [weak self] vote in
                view.setLoading(true)
                self?.interactor?.saveVote(vote: vote)
            }
            .disposed(by: disposeBag)
        }
    }
}

extension VotePresenter: VotePresenterToView {
    var registeredVote: Observable<Vote> {
        return voteBehavior.asObservable().unwrap()
    }
    
    func viewDidLoad() {
        bind()
    }    
}

extension VotePresenter: VoteInteractorOutput {
    func savedVote(vote: Vote) {
        view?.setLoading(false)
        self.voteBehavior.accept(vote)
    }
    
    func errorOccurred(error: Error?) {
        view?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
    
    
}
