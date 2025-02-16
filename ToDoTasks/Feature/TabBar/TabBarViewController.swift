import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
   private func setupTabBar() {
        tabBar.barStyle = .default
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGreen
    }
    
    func setupTaskTab(with navigationController: UINavigationController) {
        navigationController.tabBarItem = UITabBarItem(
            title: "Tasks",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )
    }
    
    func setupCalculatorTab(with navigationController: UINavigationController) {
        navigationController.tabBarItem = UITabBarItem(
            title: "Calculator",
            image: UIImage(systemName: "plus.slash.minus"),
            tag: 1
        )
    }
    
    func setupNewsTab(with navigationController: UINavigationController) {
        navigationController.tabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            tag: 2
        )
    }
}
