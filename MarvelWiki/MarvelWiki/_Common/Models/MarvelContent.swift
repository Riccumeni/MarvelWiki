//
//  MarvelContent.swift
//  MarvelWiki
//
//  Created by Michelangelo Moncada on 20/02/25.
//

import Foundation

enum MarvelContentType {
    case characters
    case comics
    case series
}

struct MarvelContent: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)

        if let titleValue = try? container.decode(String.self, forKey: .title) {
            title = titleValue
        } else {
            let dynamicContainer = try decoder.container(keyedBy: DynamicKeys.self)
            title = try dynamicContainer.decode(String.self, forKey: .name)
        }
    }

    enum DynamicKeys: String, CodingKey {
        case name
    }
}
