//
//  StoryClient.swift.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation
import RxSwift
import RxAlamofire

struct StoryClient {
    
    static func endVoting(by id: Int) -> Observable<Story> {
        return RxAlamofire.requestDecodable(.put, "\(Constant.kBaseURL)/estoria/\(id)/encerrar-votacao")
            .map { (response, story: Story) in
                return story
            }
    }
    
    static func saveStory(story: Story) -> Observable<Story> {
        /*if let jsonData = try? JSONEncoder().encode(story) {
            RxAlamofire.upload(
                jsonData,
                to: "minhaUrl",
                method: .post,
                headers: ["chave":"valor"])
                .map { response in
                    
                }
        }*/
        return RxAlamofire.requestDecodable(.post, "\(Constant.kBaseURL)/estoria")
            .map { (response, story: Story) in
                return story
            }
    }
    
    static func getStory(by id: Int) -> Observable<Story> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/estoria/\(id)")
            .map { (response, story: Story) in
                return story
            }
    }
    
    static func getSprintStories(by sprintId: Int) -> Observable<[Story]> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/estoria/sprint/\(sprintId)")
            .map { (response, stories: [Story]) in
                return stories
            }
    }
    
    
    static func deleteStory(by id: Int) -> Observable<Story> {
        return RxAlamofire.requestDecodable(.delete, "\(Constant.kBaseURL)/estoria/\(id)")
            .map { (response, story: Story) in
                return story
            }
    }
}
