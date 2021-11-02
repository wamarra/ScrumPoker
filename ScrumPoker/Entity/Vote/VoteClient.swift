//
//  VoteClient.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation
import RxSwift
import RxAlamofire

struct VoteClient {
    
    static func saveVote(vote: Vote) -> Observable<Vote> {
        return RxAlamofire.requestDecodable(.post, "\(Constant.kBaseURL)/voto")
            .map { (response, vote: Vote) in
                return vote
            }
    }
}

