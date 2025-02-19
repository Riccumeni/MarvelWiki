//
//  Comic.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}
