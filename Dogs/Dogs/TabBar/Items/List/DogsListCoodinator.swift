//
//  DogsListCoodinator.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import UIKit

protocol DogsListCoodinatorProtocol: AnyObject {
	func didPresentDetailsView(_ item: DogItemResponse)
}

final class DogsListCoodinator: Coordinator {
	var finishDelegate: CoordinatorFinishDelegate?
	
	var navigationController: UINavigationController
	
	var childCoordinators: [Coordinator]
	
	var type: CoordinatorType
	
	func start() {
		let dogsViewController = DogListViewController()
		let viewModel = DogsListViewModel(delegate: dogsViewController)
		dogsViewController.viewModel = viewModel
		dogsViewController.coordinator = self
		navigationController.pushViewController(dogsViewController,
										 animated: true)
	}
	
	required init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
		type = .list
		
		childCoordinators = []
	}
}

extension DogsListCoodinator: DogsListCoodinatorProtocol {
	func didPresentDetailsView(_ item: DogItemResponse) {
		let coordinator = DetailViewCoodinator(navigationController)
		childCoordinators.append(coordinator)
		coordinator.start(dogItem: item)
	}
}
