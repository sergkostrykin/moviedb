//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var releaseLabel: UILabel!
    @IBOutlet private var separator: UIView!
    @IBOutlet private var ratingView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(movie: Movie?, isSeparatorHidden: Bool = false) {
        
        movieTitleLabel.text = movie?.title
        movieImageView.kf.setImage(with: movie?.posterPath?.asURL, placeholder: UIImage(named: "placeholder"))
        ratingView.rating = movie?.voteAverage ?? 0
        let releaseDate = movie?.releaseDate?.apiDate?.releaseDateString ?? ""
        releaseLabel.text = "In theatres \(releaseDate)"
        separator.isHidden = isSeparatorHidden
        
    }


    
}
