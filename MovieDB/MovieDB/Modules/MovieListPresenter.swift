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
}

final class MovieListPresenter {
    
    private var router: MovieListRouter?
    
    private weak var view: MovieListView?
    
    
    func loadMovies() {
//        view?.showSpinner()
        MovieService.topRated() { [weak self] (result, error) in
            DispatchQueue.main.async {
//                self?.view?.dismissSpinner()
                if let error = error {
//                    let action = UIAlertAction(title: R.string.localizable.alert_dialog_ok(), style: .default, handler: { (_) in
//                        self?.router?.back()
//                    })
//                    self?.view?.showAlert(title: nil, message: String().localizable?.errorLoadingDataText, actions: [action])
                    return
                }
                
                guard let movies = result?.results else {
//                    let action = UIAlertAction(title: R.string.localizable.alert_dialog_ok(), style: .default, handler: { (_) in
//                        self?.router?.back()
//                    })
//                    self?.view?.showAlert(title: nil, message: String().localizable?.noProductsFound, actions: [action])
                    return
                }
//                self?.refreshProduct(product)
//                self?.loadRelatedProducts(related: product.related)
            }
        }
    }

    
    
}

extension MovieListPresenter: MovieListViewOutput {
    func didLoad() {
        loadMovies()
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
