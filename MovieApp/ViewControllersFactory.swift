
import UIKit

class ViewControllersFactory {
    private enum Constants {
        static let home = "HomeMoviesViewController"
        static let favorites = "FavoritesMoviesViewController"
        static let deitals = "DetailsMovieViewController"
    }
    
    static let shared = ViewControllersFactory()
    private init() {}
    
    func createHomeModule() -> HomeMoviesViewController {
        let homeStoryboard = UIStoryboard(name: Constants.home, bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: Constants.home) as! HomeMoviesViewController
        let homePresenter = HomeViewPresenter()
        homeViewController.setPresenter(homePresenter)
        homePresenter.view = homeViewController
        return homeViewController
    }
    
    func createFavoriteModule() -> FavoritesMoviesViewController {
        let favoritesStoryboard = UIStoryboard(name: Constants.favorites, bundle: nil)
        let favoritesMoviesViewController = favoritesStoryboard.instantiateViewController(withIdentifier: Constants.favorites) as! FavoritesMoviesViewController
        let favoritesPresenter = FavoritesViewPresenter()
        favoritesMoviesViewController.setPresenter(favoritesPresenter)
        favoritesPresenter.view = favoritesMoviesViewController
        return favoritesMoviesViewController
    }
    
    func createDetailsModule() -> DetailsMovieViewController {
        let storyboard = UIStoryboard(name: Constants.deitals, bundle: nil)
        let detailsMovieVC = storyboard.instantiateViewController(withIdentifier: Constants.deitals) as! DetailsMovieViewController
        return detailsMovieVC
    }
}
