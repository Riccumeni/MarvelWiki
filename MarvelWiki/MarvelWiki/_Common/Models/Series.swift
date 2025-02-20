//
//  Series.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 20/02/25.
//

struct Series: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}
