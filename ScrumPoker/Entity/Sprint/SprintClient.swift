//
//  SprintClient.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation
import RxSwift
import RxAlamofire

struct SprintClient {
    
    static func saveSprint(sprint: Sprint) -> Observable<Sprint> {
        return RxAlamofire.requestDecodable(.post, "\(Constant.kBaseURL)/sprint")
            .map { (response, sprint: Sprint) in
                return sprint
            }
    }
    
    static func getSprints() -> Observable<[Sprint]> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/sprint")
            .map { (response, sprints: [Sprint]) in
                return sprints
            }
    }
    
    static func getSprint(by id: Int) -> Observable<Sprint> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/sprint/\(id)")
            .map { (response, sprint: Sprint) in
                return sprint
            }
    }
    
    static func deleteSprint(by id: Int) -> Observable<Sprint> {
        return RxAlamofire.requestDecodable(.delete, "\(Constant.kBaseURL)/sprint/\(id)")
            .map { (response, sprint: Sprint) in
                return sprint
            }
    }

}
