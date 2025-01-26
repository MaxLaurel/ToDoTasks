import UIKit

final class TabBarControllerCoordinator: Coordinating, CoordinatingManager {
    
    var childCoordinators: [Coordinating] = []
    let window: UIWindow
    private var tabBarViewController: TabBarViewController?
    let navigationController: UINavigationController
    var taskViewControllerCoordinator: TaskViewControllerCoordinator
    var calculatorViewControllerCoordinator: CalculateViewControllerCoordinator
    var newsViewControllerCoordinator: NewsViewControllerCoordinator
    weak var appCoordinator: AppCoordinator?
    
    init(window: UIWindow, navigationController: UINavigationController, taskViewControllerCoordinator: TaskViewControllerCoordinator, calculatorViewControllerCoordinator: CalculateViewControllerCoordinator, newsViewControllerCoordinator: NewsViewControllerCoordinator/*appCoordinator: AppCoordinator*/ ) {
        self.window = window
        self.navigationController = navigationController
        self.taskViewControllerCoordinator = taskViewControllerCoordinator
        self.calculatorViewControllerCoordinator = calculatorViewControllerCoordinator
        self.newsViewControllerCoordinator = newsViewControllerCoordinator
  }
    
    func start() {
        
    }
    
    func startTabBarViewControllerFlow() {
        tabBarViewController = TabBarViewController()
        guard let tabBarViewController else { return }
        
        let coordinatorsToAdd: [Coordinating] = [taskViewControllerCoordinator, calculatorViewControllerCoordinator, newsViewControllerCoordinator]
        coordinatorsToAdd.forEach {
               addChildCoordinator($0)
               print("Added coordinator: \($0)")
               print("Current child coordinators: \(childCoordinators)")
           }
        coordinatorsToAdd.forEach {$0.start()}

        tabBarViewController.setupTaskTab(with: taskViewControllerCoordinator.navigationController)
        tabBarViewController.setupCalculatorTab(with: calculatorViewControllerCoordinator.navigationController)
        tabBarViewController.setupNewsTab(with: newsViewControllerCoordinator.navigationController)
        
        tabBarViewController.setViewControllers([
            taskViewControllerCoordinator.navigationController,
            calculatorViewControllerCoordinator.navigationController,
            newsViewControllerCoordinator.navigationController],
            animated: false)
        
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        
    }
}
