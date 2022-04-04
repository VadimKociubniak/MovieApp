

import UIKit

protocol HomeMoviesViewControllerProtocol: AnyObject {
    func displayDetailsMovieVC(with movie: Movie)
    func reloadTableView()
}

class HomeMoviesViewController: UIViewController {
    private enum Constants {
        static let deitalsMovieViewController = "DetailsMovieViewController"
        static let homeTableViewCell = "HomeTableViewCell"
        static let movieLab = "MovieLab"
    }
    
    @IBOutlet private var movieTableView: UITableView!
    private let factory = ViewControllersFactory.shared
    private var presenter: HomeViewPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        movieTableView.register(UINib(nibName: Constants.homeTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.homeTableViewCell)
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = Constants.movieLab
        let tabBarIteam = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        self.tabBarItem = tabBarIteam
    }
    
    func setPresenter(_ presenter: HomeViewPresenter) {
        self.presenter = presenter
    }
}

extension HomeMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let homeCell = tableView.dequeueReusableCell(withIdentifier: Constants.homeTableViewCell, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: homeCell, indexPath: indexPath)
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presenter.getCellHeight())
    }
}

extension HomeMoviesViewController: HomeMoviesViewControllerProtocol {
    func displayDetailsMovieVC(with movie: Movie) {
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
