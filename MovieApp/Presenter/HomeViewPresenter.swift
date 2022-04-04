

import Foundation

protocol HomeViewPresenterProtocol: AnyObject {
    func configure(cell: HomeTableViewCell, indexPath: IndexPath)
    func didSelectItem(indexPath: IndexPath)
    func getCellHeight() -> Double
    func getItemCount() -> Int
}

final class HomeViewPresenter {
    weak var view: HomeMoviesViewControllerProtocol?
    private let apiManager = APIManager()
    private var itemMovieHomeArray: Movies?
    
    init() {
        getMovies()
    }
    
    private func getMovies() {
        apiManager.getMovie(for: .popular) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.itemMovieHomeArray = movies
                self.view?.reloadTableView()
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewPresenter: HomeViewPresenterProtocol {
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
        view?.displayDetailsMovieVC(with: movieViewData)
    }
    
    func configure(cell: HomeTableViewCell, indexPath: IndexPath) {
        guard let movie = itemMovieHomeArray?.results[indexPath.row] else { return }
        let movieViewData = Movie(image: movie.posterPath,
                                  title: movie.title,
                                  rate: "\(movie.voteAverage)",
                                  overview: movie.overview,
                                  dates: movie.releaseDate)
        cell.configure(with: movieViewData)
    }
}
