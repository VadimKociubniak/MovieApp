
import UIKit

class DeitalsMovieViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!{
        didSet{
        movieTitle.text = movie?.title
        }
    }
    @IBOutlet weak var moviePoster: UIImageView!{
        didSet{
            guard let image = movie?.image else{return}
            moviePoster.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var movieOverview: UITextView!{
        didSet{
        movieOverview.text = movie?.overview
        }
    }
    @IBOutlet weak var movieDates: UITextView!{
        didSet{
            movieDates.text = movie?.dates
        }
    }
    @IBOutlet weak var movieRate: UITextView!{
        didSet{
            movieRate.text = movie?.rate
        }
    }
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.perform(#selector(goBack), with: nil, afterDelay: 2.0)
    }
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

