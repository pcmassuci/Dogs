//
//  CoordinatorProtocol.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 25/02/22.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }

    var navigationController: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    var type: CoordinatorType { get }

    func start()

    func finish()

    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - CoordinatorOutput

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType

enum CoordinatorType {
    case tab, list
}
