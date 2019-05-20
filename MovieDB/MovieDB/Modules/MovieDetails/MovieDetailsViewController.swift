//  
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private var output: MovieDetailsViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
}

extension MovieDetailsViewController {
    func attach(output: MovieDetailsViewOutput) {
        self.output = output
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    
}
