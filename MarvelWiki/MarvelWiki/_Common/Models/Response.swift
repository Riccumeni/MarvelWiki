//
//  Response.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

typealias CharactersResponse = Response<Character>
typealias ComicsResponse = Response<Comic>
typealias SeriesResponse = Response<Series>
typealias MarvelResponse = Response<MarvelContent>

struct Response<T: Codable>: Codable {
    let status: String
    let copyright: String
    let attributionText: String
    let data: ResponsePage<T>
}
