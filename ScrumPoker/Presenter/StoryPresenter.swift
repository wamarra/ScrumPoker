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
    func viewDidLoad()
    func bindAddStory()
    func showViewAddStory()
}

class StoryPresenter {
    weak var listController: ListStoryToPresenter?
    weak var saveController: SaveStoryToPresenter?
    
    var interactor: StoryInteractorInput?
    var storyBehavior = BehaviorRelay<Story?>(value: nil)
    var storiesBehavior = BehaviorRelay<[Story]?>(value: nil)
    var router: ListStoryBySprintRouter!
    let disposeBag = DisposeBag()
}

extension StoryPresenter: StoryPresenterToView {
    func bindAddStory() {
        if let view = self.saveController {
            view.storyObserver.bind { [weak self] story in
                view.setLoading(true)
                self?.interactor?.saveStory(story: story)
            }
            .disposed(by: disposeBag)
        }
    }
    
    func viewDidLoad() {
        self.interactor?.getStories(by: 137)
    }
    
    func showViewAddStory() {
        router.showViewAddStory()
    }
        
    var recoveredStoriesBySprint: Observable<[Story]> {
        return storiesBehavior.asObservable().unwrap()
    }
}

extension StoryPresenter: StoryInteractorOutput {
    func savedStory(story: Story) {
        self.storyBehavior.accept(story)
    }
    
    func storyDeleted() {
        listController?.setLoading(false)
    }
    
    func voteFinished(story: Story) {
        listController?.setLoading(false)
    }
    
    func storyRecovered(story: Story) {
        listController?.setLoading(false)
        self.storyBehavior.accept(story)
    }
    
    func storiesRecovered(stories: [Story]) {
        listController?.setLoading(false)
        self.storiesBehavior.accept(stories)
    }
    
    func errorOccurred(error: Error?) {
        listController?.setLoading(false)
        debugPrint(error ?? "Erro ao realizar a operação")
    }
}
