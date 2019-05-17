//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var releaseLabel: UILabel!
    @IBOutlet private var separator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(movie: Movie?, isSeparatorHidden: Bool = false) {
        
        movieTitleLabel.text = movie?.title
        separator.isHidden = isSeparatorHidden
        
    }


    
}
