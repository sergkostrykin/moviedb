//
//  MovieService.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

class MovieService {
    
    class func topRated(completion: ((MovieList?, Error?) -> Void)?) {
        let parameters = ["certification_country": "US",
                          "certification.lte": "G",
                          "sort_by": "popularity.desc"];
        let path = Environment.baseUrl + "/discover/movie"
        Connection.startTask(for: path, parameters: parameters) { json, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                let movies = try JSONDecoder().decode(MovieList?.self, from: jsonData)
                DispatchQueue.main.async {
                    completion?(movies, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                print(error)
            }
        }
    }
    
    class func movieDetails(id: Int, completion: ((Movie?, Error?) -> Void)?) {
        let path = Environment.baseUrl + "/movie/\(id)"
        Connection.startTask(for: path) { json, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                let movie = try JSONDecoder().decode(Movie?.self, from: jsonData)
                DispatchQueue.main.async {
                    completion?(movie, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                print(error)
            }
        }
    }

}
