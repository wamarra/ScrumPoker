//
//  DeveloperInteractor.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import Foundation
import RxSwift

protocol DeveloperInteractorOutput: AnyObject {
    func savedDeveloper(developer: Developer)
    func developerRecoveredById(developer: Developer)
    func developerRecoveredByEmail(developer: Developer)
    func errorOccurred(error: Error?)
}

protocol DeveloperInteractorInput: AnyObject {
    func getDeveloper(by id: Int)
    func getDeveloper(by email: String)
    func saveDeveloper(with developer: Developer)
}

class DeveloperInteractor {
    weak var output: DeveloperInteractorOutput?
    let disposeBag = DisposeBag()
}

extension DeveloperInteractor: DeveloperInteractorInput {
    func getDeveloper(by id: Int) {
        DeveloperClient.getDeveloper(by: id).subscribe { [weak self] event in
            if let developer = event.element {
                self?.output?.developerRecoveredById(developer: developer)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func getDeveloper(by email: String) {
        DeveloperClient.getDeveloper(by: email).subscribe { [weak self] event in
            if let developer = event.element {
                self?.output?.developerRecoveredByEmail(developer: developer)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func saveDeveloper(with developer: Developer) {
        DeveloperClient.saveDeveloper(developer: developer).subscribe { [weak self] event in
            if let developer = event.element {
                self?.output?.savedDeveloper(developer: developer)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
}
