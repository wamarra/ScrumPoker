//
//  DeveloperPresenter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

protocol DeveloperPresenterToView: AnyObject {
    var savedDeveloper: Observable<Developer> { get }
    func viewDidLoad()
}

class DeveloperPresenter {
    weak var view: DeveloperViewToPresenter?
    var interactor: DeveloperInteractorInput?
    let disposeBag = DisposeBag()
    var developer = BehaviorRelay<Developer?>(value: nil)
    
    func bind() {
        if let view = self.view {
            view.developerObserver
                .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .bind { [weak self] developer in
                view.setLoading(true)
                
                self?.interactor?.saveDeveloper(with: developer)
            }
            .disposed(by: disposeBag)
        }
    }
}

extension DeveloperPresenter: DeveloperPresenterToView {
    var savedDeveloper: Observable<Developer> {
        return developer.asObservable().unwrap()
    }
    
    func viewDidLoad() {
        bind()
    }
}

extension DeveloperPresenter: DeveloperInteractorOutput {
    func savedDeveloper(developer: Developer) {
        view?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func developerRecoveredById(developer: Developer) {
        view?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func developerRecoveredByEmail(developer: Developer) {
        view?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func errorOccurred(error: Error?) {
        view?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
}
