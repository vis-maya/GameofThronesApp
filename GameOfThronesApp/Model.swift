//
//  Model.swift
//  GameOfThronesApp
//
//  Created by Harvin Shibu on 28/06/23.
//

import Foundation

struct Model: Codable {
    let id: Int
    let url: String
    let name: String
    let season, number: Int
    let airdate: String
    let image: Image
    let summary: String
    
}

struct Image: Codable {
    let medium, original: String
}

