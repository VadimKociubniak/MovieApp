

import Foundation

protocol FavoritesViewPresenterProtocol: AnyObject {
    func configure(cell: FavoritesTableViewCell, indexPath: IndexPath)
    func didSelectItem(indexPath: IndexPath)
    func getCellHeight() -> Double
    func getItemCount() -> Int
}

final class FavoritesViewPresenter {
    weak var view: FavoritesMoviesViewControllerProtocol?
    private let apiManager = APIManager()
    private var itemMovieHomeArray: Movies?
    
    init() {
        self.getMovies()
    }
    
    private func getMovies() {
        apiManager.getMovie(for: .favorite) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.itemMovieHomeArray = movies
                self.view?.reloadTableView()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FavoritesViewPresenter: FavoritesViewPresenterProtocol {
    func getCellHeight() -> Double {
        350
    }
    
    func getItemCount() -> Int {
        return itemMovieHomeArray?.results.count ?? 0
    }
    
    func didSelectItem(indexPath: IndexPath) {
        guard let movie = itemMovieHomeArray?.results[indexPath.row] else { return }
        let movieViewData = Movie(image: movie.posterPath,
                                  title: movie.title,
                                  rate: "\(movie.voteAverage)",
                                  overview: movie.overview,
                                  dates: movie.releaseDate)
        view?.presentDetailsMovieVC(with: movieViewData)
    }
    
    func configure(cell: FavoritesTableViewCell, indexPath: IndexPath) {
        guard let movie = itemMovieHomeArray?.results[indexPath.row] else { return }
        let movieViewData = Movie(image: movie.posterPath,
                                  title: movie.title,
                                  rate: "\(movie.voteAverage)",
                                  overview: movie.overview,
                                  dates: movie.releaseDate)
        cell.configure(with: movieViewData)
    }
}
