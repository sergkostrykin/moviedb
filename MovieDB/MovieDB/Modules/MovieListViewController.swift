//  
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    private var output: MovieListViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
}

extension MovieListViewController {
    func attach(output: MovieListViewOutput) {
        self.output = output
    }
}

extension MovieListViewController: MovieListView {
    
}
