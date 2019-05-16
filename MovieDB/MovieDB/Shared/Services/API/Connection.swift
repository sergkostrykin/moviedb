//
//  Connection.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

class Connection {
    
    typealias Completion = (Any?, URLResponse?, Error?) -> Void
    
    enum Method: String {
        case GET
        case POST
        case PUT
    }
    
    class func startTask(for urlString: String, parameters: [String: String] = [:], body: Data? = nil, method: Method? = nil, completion: Completion?) {
        var url: URL?
        do {
            url = try Connection.url(for: urlString, parameters: parameters)
        } catch {
            completion?(nil, nil, error)
            return
        }
        
        guard let requestUrl = url else {
            let error = NSError.standard(message: "URL not found")
            completion?(nil, nil, error)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = method != nil ? method!.rawValue : body == nil ? "GET" : "POST"
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code != NSURLErrorCancelled {
                    completion?(nil, response, error)
                }
                return
            }
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                else {
                    let error = NSError.standard(message: "Error Loading Data")
                    completion?(nil, response, error)
                    return
            }
            completion?(json, response, error)
        }
        
        task.resume()
    }
    
    static func url(for urlString: String, parameters: [String: String] = [:]) throws -> URL {
        var str = urlString
        var authorizedParams = parameters
        authorizedParams["api_key"] = Constants.apiKey
        for parameter in authorizedParams {
            let value = parameter.value
            guard let validValue = value.addingPercentEncoding(withAllowedCharacters: []) else {
                let error = NSError.standard(message: "Error Loading Data")
                throw error
            }
            str += str == urlString ? "?" : "&"
            str += parameter.key + "=" + validValue
        }
        guard let url = URL(string: str) else {
            let error = NSError.standard(message: "URL not found")
            throw error
        }        
        return url
    }
}
