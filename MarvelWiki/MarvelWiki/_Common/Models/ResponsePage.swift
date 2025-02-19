//
//  ResponsePage.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

struct ResponsePage<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
