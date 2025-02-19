//
//  Character.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 18/02/25.
//

struct Character: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Thumbnail
}
