//  
//  MovieListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

protocol MovieListViewOutput: class {
    func didLoad()
    func showMovieDetails(movie: Movie)
}

final class MovieListPresenter {
    
    private var router: MovieListRouter?
    
    private weak var view: MovieListView?
    
    
    func loadMovies() {
        view?.showSpinner()
        MovieService.topRated() { [weak self] (result, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                
                guard let movies = result?.results else {
                    self?.view?.showAlert(title: "Error", message: "No movies found")
                    return
                }
                self?.view?.refresh(movies: movies)
            }
        }
    }
}

extension MovieListPresenter: MovieListViewOutput {
    func didLoad() {
        loadMovies()
    }
    
    func showMovieDetails(movie: Movie) {
        router?.showMovieDetails(movie: movie)
    }
}

extension MovieListPresenter {
    func attach(router: MovieListRouter) {
        self.router = router
    }
    
    func attach(view: MovieListView) {
        self.view = view
    }
}
