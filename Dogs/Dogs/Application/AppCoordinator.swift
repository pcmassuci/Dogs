//
//  AppCoordinator.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

/// Define what type of flows can be started from this Coordinator
protocol AppCoordinatorProtocol: Coordinator {
	func showMainFlow()
}

/// App coordinator is the only one coordinator which will exist during app's life cycle
class AppCoordinator: AppCoordinatorProtocol {
	weak var finishDelegate: CoordinatorFinishDelegate?

	var navigationController: UINavigationController

	var childCoordinators = [Coordinator]()

	var type: CoordinatorType { .tab }

	required init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
		navigationController.setNavigationBarHidden(true, animated: true)
	}

	func start() {
		showMainFlow()
	}

	func showMainFlow() {
		let tabCoordinator = TabCoordinator.init(navigationController)
		tabCoordinator.finishDelegate = self
		tabCoordinator.start()
		childCoordinators.append(tabCoordinator)
	}
}

extension AppCoordinator: CoordinatorFinishDelegate {
	func coordinatorDidFinish(childCoordinator: Coordinator) {
		childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

		switch childCoordinator.type {
		case .tab:
			navigationController.viewControllers.removeAll()
		default:
			()
		}
	}
}
