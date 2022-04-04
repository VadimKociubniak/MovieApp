
import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/original" + "\(urlString)") else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: baseURL) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
