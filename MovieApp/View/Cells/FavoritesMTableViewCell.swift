//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by Vadim Koc on 22.03.2022.
//

import UIKit

class FavoritesMTableViewCell: UITableViewCell {

    @IBOutlet private var movieTitle: UILabel!
    @IBOutlet private var moviePoster: UIImageView!
    @IBOutlet private var movieOverview: UILabel!
    @IBOutlet private var movieDates: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Movie) {
        if let image = model.image {
            moviePoster.image = UIImage(named: image)
        }
        movieTitle.text = model.title
        movieOverview.text = model.overview
        movieDates.text = model.dates
    }
}
