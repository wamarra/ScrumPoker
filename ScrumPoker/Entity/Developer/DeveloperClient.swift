//
//  DeveloperClient.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 28/10/21.
//

import Foundation
import RxSwift
import RxAlamofire

struct DeveloperClient {
    
    static func saveDeveloper(developer: Developer) -> Observable<Developer> {
        /*if let jsonData = try? JSONEncoder().encode(developer) {
            return RxAlamofire.upload(
                jsonData,
                to: "\(Constant.kBaseURL)/desenvolvedor",
                method: .post,
                headers: nil)
                .map { response in
                    print(response)
                }
        }*/
        return RxAlamofire.requestDecodable(
            .post, "\(Constant.kBaseURL)/desenvolvedor", parameters: ["nome": [developer.nome], "email":[developer.email]])
            .map { (response, developer: Developer) in
                return developer
            }
    }
    
    static func getDeveloper(by id: Int) -> Observable<Developer> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/desenvolvedor/\(id)")
            .map { (response, developer: Developer) in
                return developer
            }
    }
    
    static func getDeveloper(by email: String) -> Observable<Developer> {
        return RxAlamofire.requestDecodable(.get, "\(Constant.kBaseURL)/desenvolvedor/email/\(email)")
            .map { (response, developer: Developer) in
                return developer
            }
    }
}
