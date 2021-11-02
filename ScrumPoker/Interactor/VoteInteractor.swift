//
//  VoteInteractor.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import Foundation
import RxSwift

protocol VoteInteractorOutput: AnyObject {
    func savedVote(vote: Vote)
    func errorOccurred(error: Error?)
}

protocol VoteInteractorInput: AnyObject {
    func saveVote(vote: Vote)
}

class VoteInteractor {
    weak var output: VoteInteractorOutput?
    let disposeBag = DisposeBag()
}

extension VoteInteractor: VoteInteractorInput {
    func saveVote(vote: Vote) {
        VoteClient.saveVote(vote: vote).subscribe { [weak self] event in
            if let vote = event.element {
                self?.output?.savedVote(vote: vote)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
}
