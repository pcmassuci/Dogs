//
//  DogListViewController.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 24/02/22.
//

import UIKit

class DogListViewController: UIViewController {
	private var viewModel = DogsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
		viewModel.getList()
    }
}
