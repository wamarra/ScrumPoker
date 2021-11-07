//
//  StoryClient.swift.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

struct StoryClient {
    
    static func endVoting(by id: Int) -> Observable<Story> {
        return RxAlamofire.requestDecodable(.put, "\(Constant.kBaseURL)/estoria/\(id)/encerrar-votacao")
            .map { (response, story: Story) in
                return story
            }
    }
    
    static func saveStory(story: Story) -> Observable<Story> {
        if let jsonData = try? JSONEncoder().encode(story) {
            
            var request = URLRequest(url: URL(string: "\(Constant.kBaseURL)/estoria")!)
            request.httpBody = jsonData
            request.httpMethod = Constant.kPostMethod
            request.setValue(Constant.kApplicationJson, forHTTPHeaderField: Constant.kContentType)
            
            return RxAlamofire.request(request as URLRequestConvertible).responseJSON().map { response in
                return try response.result.get() as? Story ?? story
            }
        }
        
        return Observable.empty()
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
