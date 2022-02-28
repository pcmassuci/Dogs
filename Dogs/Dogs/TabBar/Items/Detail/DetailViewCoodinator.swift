//
//  DetailViewCoodinator.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 27/02/22.
//

import UIKit

final class DetailViewCoodinator: Coordinator {
	var finishDelegate: CoordinatorFinishDelegate?
	
	var navigationController: UINavigationController
	
	var childCoordinators: [Coordinator]
	
	var type: CoordinatorType
	
	@available(*, deprecated, message: "Use start(dogItem: DogItemResponse)")
	func start() { }
	
	func start(dogItem: DogItemResponse) {
		let detailViewController = DetailViewController()
		let viewModel = DetailViewModel(delegate: detailViewController,
										item: dogItem)
		detailViewController.viewModel = viewModel
		navigationController.pushViewController(detailViewController,
										 animated: true)
	}
	
	required init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
		type = .detail
		
		childCoordinators = []
	}
}
