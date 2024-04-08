//
//  APICaller.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/3/30.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case faileedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
            createRequest(
                with: URL(string: Constants.baseAPIURL + "/me"),
                type: .GET
            ) { baseRequest in
                let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.faileedToGetData))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(UserProfile.self, from: data)
                        print(data)
                        completion(.success(result))
                    }
                    catch {
                        
                    }
                }
                task.resume()
            }
    }
    
    
    
    public func getNewReleases(completion: @escaping ((Result<String, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=1"), type: .GET) { result in
            let task = URLSession.shared.dataTask(with: result) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        print(String(decoding: jsonData, as: UTF8.self))

                    }

                    
//                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
//                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
//                    } else {
//                        print("json data malformed")
//                    }
                    
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
            
        }
    }
}
