//
//  TabCoordinatorProtocol.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)

    func setSelectedIndex(_ index: Int)

    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [
            .dogs,
            .search]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        let controllers: [UINavigationController] = pages.map { getTabController($0) }

        prepareTabBarController(withTabControllers: controllers)
    }

    deinit {
        print("TabCoordinator deinit")
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers,
                                            animated: true)

        tabBarController.selectedIndex = TabBarPage.dogs.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
		tabBarController.tabBar.backgroundColor = .white
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.iconUnselected(),
                                                tag: page.pageOrderNumber())

        switch page {
        case .dogs:
			let dogsCoordinator = DogsListCoodinator(navController)
			dogsCoordinator.start()
			childCoordinators.append(dogsCoordinator)
        case .search:
			let searchCordinator = SearchCoordinator(navController)
			searchCordinator.start()
			childCoordinators.append(searchCordinator)
        }
		
        return navController
    }

    func currentPage() -> TabBarPage? { TabBarPage(rawValue: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage(rawValue: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}
