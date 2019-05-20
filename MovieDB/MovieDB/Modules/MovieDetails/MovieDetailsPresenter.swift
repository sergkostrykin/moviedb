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
    func back()
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
        view?.showSpinner()
        MovieService.movieDetails(id: id) { [weak self] (result, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                
                guard let movie = result else {
                    self?.view?.showAlert(title: "Error", message: "No movie found")
                    return
                }
                self?.view?.refresh(movie: movie)
            }
        }
    }

}

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func didLoad() {
        print(#function)
        loadMovieDetails()
    }
    
    func back() {
        router?.routeBack()
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
