//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Vadim Koc on 21.03.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    private enum Constants {
        static let deitalsMovieViewController = "DeitalsMovieViewController"
        static let favoritesTableViewCell = "FavoritesTableViewCell"
        static let showFavoritesVC = "showFavoritesVC"
    }

    @IBOutlet weak var movieTableView: UITableView!
   
    private let presenter = FavoritesViewPresenter()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
        }
    private func setupTableView(){
        self.movieTableView.register(UINib(nibName: Constants.favoritesTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.favoritesTableViewCell)
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    func perfonrDisplayDetailsMovieVC(parametrSender: Any){
        let detailsMovieVC = DeitalsMovieViewController()
        self.navigationController?.pushViewController(detailsMovieVC, animated: true)
    }
}

    extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return presenter.itemMovieFavoritesArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let favoritesCell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesTableViewCell, for: indexPath) as? FavoritesTableViewCell else {
                return UITableViewCell()
        }
            favoritesCell.configure(with: presenter.itemMovieFavoritesArray[indexPath.row])
            return favoritesCell
        }
        //Тут намагався передати просто контролер
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let movie = presenter.itemMovieFavoritesArray[indexPath.row]
            //self.performSegue(withIdentifier: Constants.showFavoritesVC, sender: movie)
            self.navigationController?.show(DeitalsMovieViewController, sender: movie)
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 350
        }
}

