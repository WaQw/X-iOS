//
//  AuthServices.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/28.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    
    public static var requestDomain = ""
    
    static func register(name: String, email: String, password: String, username: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users")!
        makeRequest(urlString: urlString, reqbody: ["name": name, "email": email, "password": password, "username": username]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping(_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users/login")!
        makeRequest(urlString: urlString, reqbody: ["email": email, "password": password]) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqbody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqbody, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard err == nil else {
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        task.resume()
    }
    
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users/\(id)")!
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, res, err in
            guard err == nil else {
                return
            }
            guard let data = data else {
                completion(.failure(.invalidCredentials))
                return
            }
            completion(.success(data))
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                }
            } catch let error {
                completion(.failure(.invalidCredentials))
                print(error)
            }
        }
        task.resume()
    }
}
