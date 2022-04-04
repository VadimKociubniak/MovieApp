

import UIKit

class DetailsMovieViewController: UIViewController {
    @IBOutlet private var movieTitle: UILabel!
    @IBOutlet private var moviePoster: UIImageView!
    @IBOutlet private var movieOverview: UILabel!
    @IBOutlet private var movieDates: UILabel!
    @IBOutlet private var movieRate: UILabel!
    
    var movie: Movie? {
        willSet {
            self.configure(with: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure(with movie: Movie?) {
        DispatchQueue.main.async {
            self.movieTitle.text = movie?.title
            self.movieOverview.text = movie?.overview
            self.movieDates.text = movie?.dates
            self.movieRate.text = movie?.rate
            if let image = movie?.image {
                self.moviePoster.loadImage(from: image)
            }
        }
    }
}
