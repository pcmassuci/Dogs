//
//  SearchCoordinator.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import UIKit

protocol SearchCoodinatorProtocol: AnyObject {
	func didPresentDetailsView(_ item: DogItemResponse)
}

final class SearchCoordinator: Coordinator {
	var finishDelegate: CoordinatorFinishDelegate?
	
	var navigationController: UINavigationController
	
	var childCoordinators: [Coordinator]
	
	var type: CoordinatorType
	
	func start() {
		let searchListViewController = SearchViewController()
		let viewModel = SearchViewModel(delegate: searchListViewController)
		searchListViewController.viewModel = viewModel
		searchListViewController.coordinator = self
		navigationController.pushViewController(searchListViewController,
										 animated: true)
	}
	
	required init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
		type = .list
		
		childCoordinators = []
	}
}

extension SearchCoordinator: SearchCoodinatorProtocol {
	func didPresentDetailsView(_ item: DogItemResponse) {
		let coordinator = DetailViewCoodinator(navigationController)
		childCoordinators.append(coordinator)
		coordinator.start(dogItem: item)
	}
}
