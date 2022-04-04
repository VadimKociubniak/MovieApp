

import UIKit

class HomeTableViewCell: UITableViewCell {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = nil
        moviePoster.image = nil
        movieOverview.text = nil
        movieDates.text = nil
    }
    
    func configure(with model: Movie) {
        moviePoster.loadImage(from: model.image)
        movieTitle.text = model.title
        movieOverview.text = model.overview
        movieDates.text = model.dates
    }
}
