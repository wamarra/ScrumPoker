//
//  SprintInteractor.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import Foundation
import RxSwift

protocol SprintInteractorOutput: AnyObject {
    func sprintSaved(sprint: Sprint)
    func sprintDeleted()
    func sprintsRecovered(sprints: [Sprint])
    func sprintRecovered(sprint: Sprint)
    func errorOccurred(error: Error?)
}

protocol SprintInteractorInput: AnyObject {
    func saveSprint(sprint: Sprint)
    func deleteSprint(by id: Int)
    func getSprints()
    func getSprint(by id: Int)
}

class SprintInteractor {
    weak var output: SprintInteractorOutput?
    let disposeBag = DisposeBag()
}

extension SprintInteractor: SprintInteractorInput {
    func saveSprint(sprint: Sprint) {
        SprintClient.saveSprint(sprint: sprint).subscribe { [weak self] event in
            if let sprint = event.element {
                self?.output?.sprintSaved(sprint: sprint)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func deleteSprint(by id: Int) {
        SprintClient.deleteSprint(by: id).subscribe { [weak self] event in
            if event.isCompleted {
                self?.output?.sprintDeleted()
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func getSprints() {
        SprintClient.getSprints().subscribe { [weak self] event in
            if let sprints = event.element {
                self?.output?.sprintsRecovered(sprints: sprints)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func getSprint(by id: Int) {
        SprintClient.getSprint(by: id).subscribe { [weak self] event in
            if let sprint = event.element {
                self?.output?.sprintRecovered(sprint: sprint)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
}
