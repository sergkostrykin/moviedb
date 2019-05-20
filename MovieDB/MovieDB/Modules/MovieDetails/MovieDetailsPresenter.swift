//  
//  MovieDetailsPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

protocol MovieDetailsViewOutput: class {
    func didLoad()
}

final class MovieDetailsPresenter {
    private var router: MovieDetailsRouter?
    private weak var view: MovieDetailsView?
    
    var movie: Movie?
    
    
    init(movie: Movie?) {
        self.movie = movie
    }
    

    func loadMovieDetails() {
        guard let id = movie?.id else { return }
//        view?.showSpinner()
        MovieService.movieDetails(id: id) { [weak self] (result, error) in
            DispatchQueue.main.async {
//                self?.view?.dismissSpinner()
                if let error = error {
//                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                
                guard let movie = result else {
//                    self?.view?.showAlert(title: "Error", message: "No movies found")
                    return
                }
                print("\(movie)")

//                self?.view?.refresh(movies: movies)
            }
        }
    }

}

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func didLoad() {
        print(#function)
        loadMovieDetails()
    }
}

extension MovieDetailsPresenter {
    func attach(router: MovieDetailsRouter) {
        self.router = router
    }
    
    func attach(view: MovieDetailsView) {
        self.view = view
    }
}
