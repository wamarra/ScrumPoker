//
//  StoryInteractor.swift.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 01/11/21.
//

import Foundation
import RxSwift

protocol StoryInteractorOutput: AnyObject {
    func savedStory(story: Story)
    func storyDeleted()
    func voteFinished(story: Story)
    func storyRecovered(story: Story)
    func storiesRecovered(stories: [Story])
    func errorOccurred(error: Error?)
}

protocol StoryInteractorInput: AnyObject {
    func saveStory(story: Story)
    func deleteStory(by id: Int)
    func endVoting(by id: Int)
    func getStory(by id: Int)
    func getStories(by sprintId: Int)
}

class StoryInteractor {
    weak var output: StoryInteractorOutput?
    let disposeBag = DisposeBag()
}

extension StoryInteractor: StoryInteractorInput {
    func saveStory(story: Story) {
        StoryClient.saveStory(story: story).subscribe { [weak self] event in
            if let story = event.element {
                self?.output?.savedStory(story: story)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func deleteStory(by id: Int) {
        StoryClient.deleteStory(by: id).subscribe { [weak self] event in
            if event.isCompleted {
                self?.output?.storyDeleted()
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func endVoting(by id: Int) {
        StoryClient.endVoting(by: id).subscribe { [weak self] event in
            if let story = event.element {
                self?.output?.voteFinished(story: story)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func getStory(by id: Int) {
        StoryClient.getStory(by: id).subscribe { [weak self] event in
            if let story = event.element {
                self?.output?.storyRecovered(story: story)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    func getStories(by sprintId: Int) {
        StoryClient.getSprintStories(by: sprintId).subscribe { [weak self] event in
            if let stories = event.element {
                self?.output?.storiesRecovered(stories: stories)
            }
            if let error = event.error {
                self?.output?.errorOccurred(error: error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    
}
