//
//  Thumbnail.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

struct Thumbnail: Codable {
    let path: String
    let urlExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case urlExtension = "extension"
    }
}
