//
//  SeriesRepository.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 20/02/25.
//

import Foundation

protocol SeriesRepository{
    func getSeries(filters: [String: Any], completion: @escaping (Result<SeriesResponse, Error>) -> Void)
}

class SeriesRepositoryImpl: SeriesRepository{
    func getSeries(filters: [String : Any] = [:], completion: @escaping (Result<SeriesResponse, Error>) -> Void) {
        MWNetworkManager.shared.get(path: "/series", queryParams: []){ result in
            switch result {
            case .success(let data):
                do {
                    let seriesResponse = try JSONDecoder().decode(SeriesResponse.self, from: data)
                    completion(.success(seriesResponse))
                } catch {
                    completion(.failure(NSError.init(domain: "MarvelWiki", code: 400, userInfo: ["message" : "casting error"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
