//  
//  MovieListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

protocol MovieListViewOutput: class {
    func didLoad()
}

final class MovieListPresenter {
    private var router: MovieListRouter?
    private weak var view: MovieListView?
}

extension MovieListPresenter: MovieListViewOutput {
    func didLoad() {
        print(#function)
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
