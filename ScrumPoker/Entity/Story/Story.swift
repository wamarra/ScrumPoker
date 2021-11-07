//
//  Story.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation

struct Story: Codable {
    var id, idSprint: Int?
    var nome, link: String?
    var pontuacao: Int?
}
