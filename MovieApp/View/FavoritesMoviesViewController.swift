
import UIKit

protocol FavoritesMoviesViewControllerProtocol: AnyObject {
    func presentDetailsMovieVC(with movie: Movie)
    func reloadTableView()
}

class FavoritesMoviesViewController: UIViewController {
    private enum Constants {
        static let deitalsMovieViewController = "DetailsMovieViewController"
        static let favoritesTableViewCell = "FavoritesTableViewCell"
        static let movieLab = "MovieLab"
    }
    
    @IBOutlet private var movieTableView: UITableView!
    private let factory = ViewControllersFactory.shared
    private var presenter: FavoritesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        movieTableView.register(UINib(nibName: Constants.favoritesTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.favoritesTableViewCell)
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = Constants.movieLab
        let tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        self.tabBarItem = tabBarItem
    }
    
    func setPresenter(_ presenter: FavoritesViewPresenter) {
        self.presenter = presenter
    }
}

extension FavoritesMoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoritesCell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesTableViewCell, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: favoritesCell, indexPath: indexPath)
        return favoritesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.getCellHeight()
    }
}

extension FavoritesMoviesViewController: FavoritesMoviesViewControllerProtocol {
    func presentDetailsMovieVC(with movie: Movie) {
        DispatchQueue.main.async {
            let detailsMovieVC = self.factory.createDetailsModule()
            detailsMovieVC.movie = movie
            self.navigationController?.pushViewController(detailsMovieVC, animated: true)
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
}


