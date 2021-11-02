//
//  Story.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation

struct Story: Codable {
    let id, idSprint: Int?
    let nome, link: String?
    let pontuacao: Int?
}
