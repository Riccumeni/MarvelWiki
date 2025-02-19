//
//  CharactersResponse.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 18/02/25.
//

struct CharactersResponse: Codable {
    let status: String
    let copyright: String
    let attributionText: String
    let data: CharactersPage
}

struct CharactersPage: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let urlExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case urlExtension = "extension"
    }
}
