//
//  CharactersRepository.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

import Foundation

protocol CharactersRepository{
    func getCharacters(filters: [String: Any], completion: @escaping (Result<CharactersResponse, Error>) -> Void)
}

class CharactersRepositoryImpl: CharactersRepository{
    func getCharacters(filters: [String : Any] = [:], completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        MWNetworkManager.shared.get(path: "/characters", queryParams: []){ result in
            switch result {
            case .success(let data):
                do {
                    let characterResponse = try JSONDecoder().decode(CharactersResponse.self, from: data)
                    completion(.success(characterResponse))
                } catch {
                    completion(.failure(NSError.init(domain: "MarvelWiki", code: 400, userInfo: ["message" : "casting error"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
