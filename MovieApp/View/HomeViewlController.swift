//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Vadim Koc on 21.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    // такі константи винось для кожного класу в такі енуми
    private enum Constants {
        static let deitalsMovieViewController = "DeitalsMovieViewController"
        static let homeTableViewCell = "HomeTableViewCell"
        static let showHomeVC = "showHomeVC"
    }
    
    @IBOutlet private var movieTableView: UITableView!
    private let presenter = HomeViewPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        self.movieTableView.register(UINib(nibName: Constants.homeTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.homeTableViewCell)
        self.movieTableView.dataSource = self
        self.movieTableView.delegate = self
    }
    func perfonrDisplayDetailsMovieVC(parametrSender: Any){
        let detailsMovieVC = DeitalsMovieViewController()
        self.navigationController?.pushViewController(detailsMovieVC, animated: true)
    }
    
        // Заміни всі сігвеї на UINavigationController, загугли як це робити
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showHomeVC {
           if let vc = segue.destination as? ViewController {
               let movie = segue as? Movie
               vc.movie = movie
        }
    }
    }*/
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemMovieHomeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Краще використовувати гуард для таких випадків
        guard let homeCell = tableView.dequeueReusableCell(withIdentifier: Constants.homeTableViewCell, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        homeCell.configure(with: presenter.itemMovieHomeArray[indexPath.row])
        return homeCell
    }
    // Тут намагався передати через String
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter.itemMovieHomeArray[indexPath.row]
        self.navigationController?.show(Constants.deitalsMovieViewController, sender: movie)
    }
    
    // Метод для того, щоб виставити висоту ячейкам
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

