//
//  TexioHTTP.swift
//  TexioSwift
//
//  Created by Shayan on 5/25/17.
//
//

import Foundation

class TexioHTTP {
    
    typealias JSON = [String : Any]
    
    /// this will be the endpoint of every request
    static func makeRequest(_ route : String, _ json : JSON, header : [String : String] = [:], _ method : httpMethods = .POST, completion : ((Data?, URLResponse?, Error?) -> Void)? = nil) {
        guard let url = URL(string: route) else { return }
        var request = URLRequest(url: url)
        
        guard let json = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            return
        }
        
        request.httpBody = json
        request.httpMethod = method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let session = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if completion != nil {
                completion!(data, urlResponse, error)
            }
        }
        
        
        session.resume()
    }
    
    enum httpMethods : String {
        case GET = "GET"
        case POST = "POST"
        case PATCH = "PATCH"
    }

    
}
