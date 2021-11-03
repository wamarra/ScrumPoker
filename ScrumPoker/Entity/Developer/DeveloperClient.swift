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
        let jsonData = try? JSONEncoder().encode(developer)
        var request = URLRequest(url: URL(string: "\(Constant.kBaseURL)/desenvolvedor")!)
            request.httpBody = jsonData
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return RxAlamofire.request(request).responseJSON().map { (response) in
            return try response.result.get() as? Developer ?? developer
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
