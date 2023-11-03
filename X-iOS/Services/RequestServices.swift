//
//  RequestServices.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/30.
//

import Foundation

public class RequestServices {
    
    public static var requestDomain = ""
    
    public static func postTweet(text: String, user: String, username: String, userId: String, completion: @escaping (_ result: [String: Any]?) -> Void) {
        let params = ["text": text, "user": user, "username": username, "userId": userId] as [String: Any]
        var request = URLRequest(url: URL(string: requestDomain)!)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        // Authentication in the HTTP Request
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(json)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    static func fetchTweets(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: requestDomain)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            guard let data = data else {
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
