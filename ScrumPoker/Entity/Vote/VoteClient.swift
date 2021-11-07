//
//  VoteClient.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

struct VoteClient {
    
    static func saveVote(vote: Vote) -> Observable<Vote> {
        
        if let jsonData = try? JSONEncoder().encode(vote) {
            
            var request = URLRequest(url: URL(string: "\(Constant.kBaseURL)/voto")!)
            request.httpBody = jsonData
            request.httpMethod = Constant.kPostMethod
            request.setValue(Constant.kApplicationJson, forHTTPHeaderField: Constant.kContentType)
            
            return RxAlamofire.request(request as URLRequestConvertible).responseJSON().map { response in
                return try response.result.get() as? Vote ?? vote
            }
        }
        
        return Observable.empty()
    }
}

