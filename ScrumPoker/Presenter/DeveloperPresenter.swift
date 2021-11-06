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
    var developerRecoveredById: Observable<Developer> { get }
    var developerRecoveredByEmail: Observable<Developer> { get }
    func viewDidLoad()
    func findViewDidLoad()
    func showViewFindDeveloper()
}

class DeveloperPresenter {
    weak var saveViewController: SaveDeveloperToPresenter?
    weak var findViewController: FindDeveloperToPresenter?
    var interactor: DeveloperInteractorInput?
    var developer = BehaviorRelay<Developer?>(value: nil)
    var router: SaveDeveloperRouter!
    let disposeBag = DisposeBag()
    
    func bind() {
        if let view = self.saveViewController {
            view.developerObserver
                .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .bind { [weak self] developer in
                view.setLoading(true)
                
                self?.interactor?.saveDeveloper(with: developer)
            }
            .disposed(by: disposeBag)
        }
    }
    
    func findDeveloperBind() {
        if let view = self.findViewController {
            view.developerObserver
                .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .bind { [weak self] developer in
                view.setLoading(true)
                
                    if developer.id != nil {
                        self?.interactor?.getDeveloper(by: developer.id!)
                    } else {
                        self?.interactor?.getDeveloper(by: developer.email!)
                    }
            }
            .disposed(by: disposeBag)
        }
    }
    
    func showViewFindDeveloper() {
        router.showViewFindDeveloper()
    }
}

extension DeveloperPresenter: DeveloperPresenterToView {
    var savedDeveloper: Observable<Developer> {
        return developer.asObservable().unwrap()
    }
    
    var developerRecoveredById: Observable<Developer> {
        return developer.asObservable().unwrap()
    }
    
    var developerRecoveredByEmail: Observable<Developer> {
        return developer.asObservable().unwrap()
    }
    
    func viewDidLoad() {
        bind()
    }
    
    func findViewDidLoad() {
        findDeveloperBind()
    }
}

extension DeveloperPresenter: DeveloperInteractorOutput {
    func savedDeveloper(developer: Developer) {
        saveViewController?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func developerRecoveredById(developer: Developer) {
        findViewController?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func developerRecoveredByEmail(developer: Developer) {
        findViewController?.setLoading(false)
        self.developer.accept(developer)
    }
    
    func errorOccurred(error: Error?) {
        saveViewController?.setLoading(false)
        findViewController?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
}
