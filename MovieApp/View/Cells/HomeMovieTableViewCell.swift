//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Vadim Koc on 21.03.2022.
//

import UIKit

class HomeMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieOverview: UITextView!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieDates: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var movie: Movie?{
        didSet{
            movieTitle.text = movie?.title
            movieOverview.text = movie?.overview
            if let image = movie?.image{
                moviePoster.image = UIImage(named: image)
            }
            movieDates.text = movie?.dates
        }
    }
}
