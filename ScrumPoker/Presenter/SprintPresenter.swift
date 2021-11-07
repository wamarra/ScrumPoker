//
//  SprintPresenter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 06/11/21.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

protocol SprintPresenterToView: AnyObject {
    var sprintListed: Observable<[Sprint]> { get }
    func viewDidLoad()
    func showViewAddSprint()
}

class SprintPresenter {
    weak var listSprintController: ListSprintToPresenter?
    weak var saveSprintController: SaveSprintToPresenter?
    
    var interactor: SprintInteractorInput?
    var sprintBehavior = BehaviorRelay<Sprint?>(value: nil)
    var sprintsBehavior = BehaviorRelay<[Sprint]?>(value: nil)
    var router: ListSprintRouter!
    let disposeBag = DisposeBag()
    
    func listBind() {
        if let view = self.listSprintController {
            view.sprintsObserver.bind { [weak self] _ in
                view.setLoading(true)                
                self?.interactor?.getSprints()
            }
            .disposed(by: disposeBag)
        }
    }
}

extension SprintPresenter: SprintPresenterToView {
    func showViewAddSprint() {
        router.showViewAddSprint()
    }
    
    var sprintListed: Observable<[Sprint]> {
        return sprintsBehavior.asObservable().unwrap()
    }
    
    func viewDidLoad() {
        listBind()
    }
}

extension SprintPresenter: SprintInteractorOutput {
    func sprintSaved(sprint: Sprint) {
        listSprintController?.setLoading(false)
        self.sprintBehavior.accept(sprint)
    }
    
    func sprintDeleted() {
        listSprintController?.setLoading(false)
    }
    
    func sprintsRecovered(sprints: [Sprint]) {
        listSprintController?.setLoading(false)
        self.sprintsBehavior.accept(sprints)
    }
    
    func sprintRecovered(sprint: Sprint) {
        listSprintController?.setLoading(false)
        self.sprintBehavior.accept(sprint)
    }
    
    func errorOccurred(error: Error?) {
        listSprintController?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
}
