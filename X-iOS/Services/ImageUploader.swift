//
//  ImageUploader.swift
//  X-iOS
//
//  Created by Anqi on 2023/11/1.
//

import SwiftUI

struct ImageUploader {
    
    static func uploadImage(paramName: String, fileName: String, urlPath: String, image: UIImage) {
        let url = URL(string: "http://localhost:3000\(urlPath)")
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // Authentication
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Add image data to raw HTTP request data
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        URLSession.shared.uploadTask(with: request, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String:Any] {
                    print(json)
                }
            }
        }).resume()
    }
}
