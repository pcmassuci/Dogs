//
//  SearchCoordinator.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import UIKit

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

extension SearchCoordinator: DogsListCoodinatorProtocol {
	func didPresentDetailsView() {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .green
		navigationController.navigationBar.isHidden = false
		navigationController.pushViewController(viewController,
												animated: true)
	}
}
