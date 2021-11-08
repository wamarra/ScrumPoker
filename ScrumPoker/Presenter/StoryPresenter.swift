//
//  StoryPresenter.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 07/11/21.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxRelay

protocol StoryPresenterToView: AnyObject {
    var recoveredStoriesBySprint: Observable<[Story]> { get }
    func findStories(sprintId: Int)
}

class StoryPresenter {
    weak var view: ListStoryToPresenter?
    
    var interactor: StoryInteractorInput?
    var storyBehavior = BehaviorRelay<Story?>(value: nil)
    var storiesBehavior = BehaviorRelay<[Story]?>(value: nil)
    let disposeBag = DisposeBag()
}

extension StoryPresenter: StoryPresenterToView {
    func findStories(sprintId: Int) {
        if let view = self.view {
            view.storiesObserver.bind { [weak self] sprintId in
                view.setLoading(true)
                self?.interactor?.getStories(by: sprintId)
            }
            .disposed(by: disposeBag)
        }
    }
    
    var recoveredStoriesBySprint: Observable<[Story]> {
        return storiesBehavior.asObservable().unwrap()
    }
}

extension StoryPresenter: StoryInteractorOutput {
    func savedStory(story: Story) {
        view?.setLoading(false)
        self.storyBehavior.accept(story)
    }
    
    func storyDeleted() {
        view?.setLoading(false)
    }
    
    func voteFinished(story: Story) {
        view?.setLoading(false)
    }
    
    func storyRecovered(story: Story) {
        view?.setLoading(false)
        self.storyBehavior.accept(story)
    }
    
    func storiesRecovered(stories: [Story]) {
        view?.setLoading(false)
        self.storiesBehavior.accept(stories)
    }
    
    func errorOccurred(error: Error?) {
        view?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
}
