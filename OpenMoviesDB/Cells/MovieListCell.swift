//
//  MovieListCell.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!

    func setMovieCellData(movieObj: Movie) {
        movieImageView.loadImageUsingCache(withUrl: movieObj.poster)
        movieTitleLbl.text = movieObj.title
    }
}
