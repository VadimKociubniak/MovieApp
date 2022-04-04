

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let factory = ViewControllersFactory.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScenec = (scene as? UIWindowScene) else { return }
        
        let homeViewController = factory.createHomeModule()
        let homeNavigation = UINavigationController(rootViewController: homeViewController)
        
        let favoritesMoviesViewController = factory.createFavoriteModule()
        let favoritesNavigation = UINavigationController(rootViewController: favoritesMoviesViewController)
        
        let tabBarVC = UITabBarController()
        setupTabBarController(controller: tabBarVC)
        tabBarVC.setViewControllers([homeNavigation, favoritesNavigation], animated: true)
        
        window = UIWindow(windowScene: windowScenec)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    private func setupTabBarController(controller: UITabBarController) {
        controller.tabBar.backgroundColor = .black
        controller.tabBarItem.badgeColor = .orange
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

