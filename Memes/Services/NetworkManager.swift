//
//  NetworkManager.swift
//  Memes
//
//  Created by Алексей on 19.03.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

enum Link {
    case mem
    
    var url: URL {
        URL(string: "https://api.imgflip.com/get_memes")!
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMem(from url: URL, completion: @escaping (Result<Mem, NetworkError>) -> Void) {
        URLSession.shared.dataTask(
            with: Link.mem.url
        ) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(Mem.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
