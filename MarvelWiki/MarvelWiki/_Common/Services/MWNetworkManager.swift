//
//  MWNetworkManager.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 18/02/25.
//

import Foundation
import CommonCrypto

class MWNetworkManager {
    static let shared = MWNetworkManager()
    
    private static var kPrivateKey: String {
        return Bundle.main.infoDictionary?["PRIVATE_API_KEY"] as? String ?? ""
    }
    private static var kPublicKey: String {
        return Bundle.main.infoDictionary?["PUBLIC_API_KEY"] as? String ?? ""
    }
    private static var kBaseURLString: String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    private static var kTs: String {
        return String(Int64(Date().timeIntervalSince1970))
    }
    
    private static var kHashMD5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let string = "\(Self.kTs)\(Self.kPrivateKey)\(Self.kPublicKey)"
        let messageData = string.data(using:.utf8)!
        var digest = [UInt8](repeating: 0, count: length)
        

        _ = messageData.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(messageData.count), &digest)
        }

        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    public func get(path: String, queryParams: [URLQueryItem] = [], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = buildURL(path, queryParams: queryParams) else {
            completion(.failure(NSError.init(domain: "MarvelWiki", code: 404, userInfo: ["message" : "url not found"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    print(String(describing: error))
                }
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    print("Statuc code error: \(String(describing: response))")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("No data")
                }
                return
            }
            
            DispatchQueue.main.async {
                print(String(data: data, encoding: .utf8) ?? "No data")
                completion(.success(data))
            }
            
        }
        task.resume()
    }
    
    // MARK: - Private methods
    
    private func buildURL(_ path: String, queryParams: [URLQueryItem] = []) -> URL? {
        var url = URL(string: "https://\(Self.kBaseURLString)\(path)")
        url = url?.appending(queryItems: [
            URLQueryItem(name: "ts", value: Self.kTs),
            URLQueryItem(name: "apikey", value: Self.kPublicKey),
            URLQueryItem(name: "hash", value: Self.kHashMD5),
        ] + queryParams)
        return url
    }
}
