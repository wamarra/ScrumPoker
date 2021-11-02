//
//  Vote.swift
//  ScrumPoker
//
//  Created by Wesley Marra on 29/10/21.
//

import Foundation

struct Vote: Codable {
    let idEstoria, idDesenvolvedor, pontos: Int?
    let dataHora: String?
}
